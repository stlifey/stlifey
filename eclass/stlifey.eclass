
inherit kernel-2 versionator

RESTRICT="mirror"

K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"

KMV="$(get_version_component_range 1-2)"
KMSV="$(get_version_component_range 1).0"

KV_FULL="${PVR}-e"
SLOT="${KMV}"
S="${WORKDIR}/linux-${KV_FULL}"

KNOWN_FEATURES="ck bfq cjk uksm reiser4 fbcondecor"

featureKnown() {
	local feature="${1/-/}"
	feature="${feature/+/}"
	[ "${feature}" == "" ] && die "Feature not defined!"

	expr index "${SUPPORTED_FEATURES}" "${feature}" >/dev/null || die "${feature} is not supported in current kernel"
	expr index "${KNOWN_FEATURES}" "${feature}" >/dev/null || die "${feature} is not known"
	IUSE="${IUSE} ${feature}"
	case ${feature} in

		ck)		ck_url="http://ck.kolivas.org/patches"
				ck_src="${ck_url}/${KMSV}/${KMV}/${KMV}-ck${ck_version}/patch-${KMV}-ck${ck_version}.bz2"
				HOMEPAGE="${HOMEPAGE} ${ck_url}"
				SRC_URI="
					${SRC_URI}
					ck?	( ${ck_src} )
				"
				CK_PATCHES="${DISTDIR}/patch-${KMV}-ck${ck_version}.bz2:1"
				UNIPATCH_LIST="${UNIPATCH_LIST} ${CK_PATCHES}"
			;;
		bfq)		bfq_url="http://algo.ing.unimo.it/people/paolo/disk_sched"
				bfq_src="${bfq_url}/patches/${bfq_kernel_version}-v${bfq_version}/0001-block-cgroups-kconfig-build-bits-for-BFQ-v${bfq_version}-${KMV}.patch ${bfq_url}/patches/${bfq_kernel_version}-v${bfq_version}/0002-block-introduce-the-BFQ-v${bfq_version}-I-O-sched-for-${KMV}.patch"
				HOMEPAGE="${HOMEPAGE} ${bfq_url}"
				SRC_URI="
					${SRC_URI}
					bfq?	( ${bfq_src} )
				"

			;;
		cjk)		cjk_url="http://repo.or.cz/w/linux-2.6/cjktty.git"
				cjk_src="${cjk_url}/patch/611e97828af5c42355c870b9c7e4137e166b7220 -> vt-fix-255-glyph-limit-prepare-for-CJK-font-support.patch ${cjk_url}/patch/286181b3fabb5a982cf6dd55683109d2831ff97d -> vt-diable-setfont-if-we-have-cjk-font-in-kernel.patch ${cjk_url}/patch/60b2ff855ccbcf6cbacd5e8beba0285712eb0929 -> vt-add-cjk-font-that-has-65536-chars.patch ${cjk_url}/patch/8ff71e69d24ffa02fb8d79b4c88e292a9b9303e3 -> vt-default-to-cjk-font.patch"
				HOMEPAGE="${HOMEPAGE} ${cjk_url}"
				SRC_URI="
					${SRC_URI}
					cjk?	( ${cjk_src} )
				"
				cjk_patch() {
					epatch "${DISTDIR}"/vt-fix-255-glyph-limit-prepare-for-CJK-font-support.patch
					epatch "${DISTDIR}"/vt-diable-setfont-if-we-have-cjk-font-in-kernel.patch
					epatch "${DISTDIR}"/vt-add-cjk-font-that-has-65536-chars.patch
					epatch "${DISTDIR}"/vt-default-to-cjk-font.patch
				}
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
				UNIPATCH_LIST="${UNIPATCH_LIST} ${UKSM_PATCHES}"
			;;
		reiser4) 	reiser4_url="http://sourceforge.net/projects/reiser4"
				reiser4_src="${reiser4_url}/files/reiser4-for-linux-3.x/reiser4-for-${reiser4_kernel_version}.patch.gz"
				HOMEPAGE="${HOMEPAGE} ${reiser4_url}"
				SRC_URI="
					${SRC_URI}
					reiser4?		( ${reiser4_src} )
				"
				REISER4_PATCHES="${DISTDIR}/reiser4-for-${reiser4_kernel_version}.patch.gz:1"
				UNIPATCH_LIST="${UNIPATCH_LIST} ${REISER4_PATCHES}"
			;;
		fbcondecor) 	fbcondecor_url="http://dev.gentoo.org/~spock/projects/fbcondecor"
				fbcondecor_src="http://sources.gentoo.org/cgi-bin/viewvc.cgi/linux-patches/genpatches-2.6/trunk/${KMV}/4200_fbcondecor-0.9.6.patch"
				HOMEPAGE="${HOMEPAGE} ${fbcondecor_url}"
				SRC_URI="
					${SRC_URI}
					fbcondecor?		( ${fbcondecor_src} )
				"
				FBCONDECOR_PATCHES="${DISTDIR}/4200_fbcondecor-${fbcondecor_version}.patch:1"
				UNIPATCH_LIST="${UNIPATCH_LIST} ${FBCONDECOR_PATCHES}"
				use cjk && REQUIRED_USE="cjk? ( !fbcondecor )"
			;;
	esac
}

for I in ${SUPPORTED_FEATURES}; do
	featureKnown "${I}"
done

SRC_URI="
	${SRC_URI}
	${ARCH_URI}
	${KERNEL_URI}
"

UNIPATCH_STRICTORDER="yes"

HOMEPAGE="http://www.kernel.org ${HOMEPAGE}"

src_unpack() {
	kernel-2_src_unpack

	use ck && sed -i -e 's/\(^EXTRAVERSION :=.*$\)/# \1/' "${S}/Makefile"

	rm -rf ${S}/Documentation/* && touch ${S}/Documentation/Makefile
	rm -rf ${S}/drivers/video/logo/* && touch ${S}/drivers/video/logo/{Makefile,Kconfig}
	rm -rf ${S}/a && rm -rf ${S}/b

	use cjk && cjk_patch
}