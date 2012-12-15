
inherit kernel-2 versionator

RESTRICT="mirror"

K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"

KMV="$(get_version_component_range 1-2)"
KMSV="$(get_version_component_range 1).0"

KV_FULL="${PVR}-e"
SLOT="${KMV}"
S="${WORKDIR}/linux-${KV_FULL}"

KNOWN_FEATURES="ck bfq cjktty uksm reiser4 fbcondecor"

USE_ENABLE() {
	local USE="${1/-/}"
	USE="${USE/+/}"
	[ "${USE}" == "" ] && die "Feature not defined!"

	expr index "${SUPPORTED_USE}" "${USE}" >/dev/null || die "${USE} is not supported in current kernel"
	expr index "${KNOWN_FEATURES}" "${USE}" >/dev/null || die "${USE} is not known"
	IUSE="${IUSE} ${USE}"
	case ${USE} in

		ck)		ck_url="http://ck.kolivas.org/patches"
				ck_src="${ck_url}/${KMSV}/${KMV}/${KMV}-ck${ck_version}/patch-${KMV}-ck${ck_version}.bz2"
				HOMEPAGE="${HOMEPAGE} ${ck_url}"
				SRC_URI="
					${SRC_URI}
					ck?	( ${ck_src} )
				"
				CK_PATCHES="${DISTDIR}/patch-${KMV}-ck${ck_version}.bz2:1"
			;;
		bfq)		bfq_url="http://algo.ing.unimo.it/people/paolo/disk_sched"
				bfq_src="${bfq_url}/patches/${bfq_kernel_version}-v${bfq_version}/0001-block-cgroups-kconfig-build-bits-for-BFQ-v${bfq_version}-${KMV}.patch ${bfq_url}/patches/${bfq_kernel_version}-v${bfq_version}/0002-block-introduce-the-BFQ-v${bfq_version}-I-O-sched-for-${KMV}.patch"
				HOMEPAGE="${HOMEPAGE} ${bfq_url}"
				SRC_URI="
					${SRC_URI}
					bfq?	( ${bfq_src} )
				"
				BFQ_PATCHES="${DISTDIR}/0001-block-cgroups-kconfig-build-bits-for-BFQ-v${bfq_version}-${KMV}.patch:1 ${DISTDIR}/0002-block-introduce-the-BFQ-v${bfq_version}-I-O-sched-for-${KMV}.patch:1"
			;;
		cjktty)		cjktty_url="http://sourceforge.net/projects/cjktty"
				cjktty_src="${cjktty_url}/files/cjktty-for-linux-3.x/cjktty-for-${cjktty_kernel_version}.patch.xz"
				HOMEPAGE="${HOMEPAGE} ${cjktty_url}"
				SRC_URI="
					${SRC_URI}
					cjktty?		( ${cjktty_src} )
				"
				if [ "${SUPPORTED_USE/cjktty/}" != "$SUPPORTED_USE" ];
					then CJKTTY_PATCHES="${DISTDIR}/cjktty-for-${cjktty_kernel_version}.patch.xz:1";
				fi
			;;
		uksm)		uksm_url="http://kerneldedup.org"
				uksm_sub_version="$(echo $uksm_kernel_version | cut -f 3 -d .)"
				uksm_src="${uksm_url}/download/uksm/${uksm_version}/uksm-${uksm_version}-for-v${KMV}.ge.${uksm_sub_version}.patch"
				HOMEPAGE="${HOMEPAGE} ${uksm_url}"
				SRC_URI="
					${SRC_URI}
					uksm?		( ${uksm_src} )
				"
				UKSM_PATCHES="${DISTDIR}/uksm-${uksm_version}-for-v${KMV}.ge.${uksm_sub_version}.patch:1"
			;;
		reiser4) 	reiser4_url="http://sourceforge.net/projects/reiser4"
				reiser4_src="${reiser4_url}/files/reiser4-for-linux-3.x/reiser4-for-${reiser4_kernel_version}.patch.gz"
				HOMEPAGE="${HOMEPAGE} ${reiser4_url}"
				SRC_URI="
					${SRC_URI}
					reiser4?		( ${reiser4_src} )
				"
				REISER4_PATCHES="${DISTDIR}/reiser4-for-${reiser4_kernel_version}.patch.gz:1"

			;;
		fbcondecor) 	fbcondecor_url="http://dev.gentoo.org/~spock/projects/fbcondecor"
				fbcondecor_src="http://sources.gentoo.org/cgi-bin/viewvc.cgi/linux-patches/genpatches-2.6/trunk/${KMV}/4200_fbcondecor-${fbcondecor_version}.patch -> 4200_fbcondecor-${KMV}-${fbcondecor_version}.patch"
				HOMEPAGE="${HOMEPAGE} ${fbcondecor_url}"
				SRC_URI="
					${SRC_URI}
					fbcondecor?		( ${fbcondecor_src} )
				"
				if [ "${SUPPORTED_USE/fbcondecor/}" != "$SUPPORTED_USE" ];
					then FBCONDECOR_PATCHES="${DISTDIR}/4200_fbcondecor-${KMV}-${fbcondecor_version}.patch:1";
				fi
			;;
	esac
}

for I in ${SUPPORTED_USE}; do
	USE_ENABLE "${I}"
done

use ck && UNIPATCH_LIST="${UNIPATCH_LIST} ${CK_PATCHES}"
use bfq && UNIPATCH_LIST="${UNIPATCH_LIST} ${BFQ_PATCHES}"
use cjktty && UNIPATCH_LIST="${UNIPATCH_LIST} ${CJKTTY_PATCHES}"
use uksm && UNIPATCH_LIST="${UNIPATCH_LIST} ${UKSM_PATCHES}"
use reiser4 && UNIPATCH_LIST="${UNIPATCH_LIST} ${REISER4_PATCHES}"
use fbcondecor && UNIPATCH_LIST="${UNIPATCH_LIST} ${FBCONDECOR_PATCHES}"

if [ "${SUPPORTED_USE/cjktty/}" != "$SUPPORTED_USE" -a "${SUPPORTED_USE/fbcondecor/}" != "$SUPPORTED_USE" ];
	then REQUIRED_USE="cjktty? ( !fbcondecor )";
fi

SRC_URI="
	${SRC_URI}
	${ARCH_URI}
	${KERNEL_URI}
"

UNIPATCH_STRICTORDER="yes"

src_unpack() {
	kernel-2_src_unpack

	sed -i -e "s:^\(EXTRAVERSION =\).*:\1 ${EXTRAVERSION}:" Makefile

	if [ "${SUPPORTED_USE/ck/}" != "$SUPPORTED_USE" ];
		then use ck && sed -i -e 's/\(^EXTRAVERSION :=.*$\)/# \1/' "${S}/Makefile";
	fi

	rm -rf ${S}/Documentation/* && touch ${S}/Documentation/Makefile
	rm -rf ${S}/drivers/video/logo/* && touch ${S}/drivers/video/logo/{Makefile,Kconfig}
	rm -rf ${S}/a && rm -rf ${S}/b
}