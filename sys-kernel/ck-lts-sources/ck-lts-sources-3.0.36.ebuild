# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"
K_DEBLOB_AVAILABLE="1"
ETYPE="sources"

inherit kernel-2 versionator
detect_version
detect_arch

SUB_VERSION="$(get_version_component_range 3)"
BASE_VERSION="$(get_version_component_range 1-2)"
MAIN_VERSION="$(get_version_component_range 1).0"
FULL_VERSION="${BASE_VERSION}.0"

ck_version="1"
ck_url="http://ck.kolivas.org/patches"
ck_src="${ck_url}/${MAIN_VERSION}/${BASE_VERSION}/${FULL_VERSION}-ck${ck_version}/patch-${FULL_VERSION}-ck${ck_version}.bz2
	${ck_url}/bfs/${FULL_VERSION}/${BASE_VERSION}-ck${ck_version}-bfs-406-413.patch"
use ck && CK_PATCHES="${FILESDIR}/ck-patchset-fix.patch
	${DISTDIR}/patch-${FULL_VERSION}-ck${ck_version}.bz2
	${DISTDIR}/${BASE_VERSION}-ck${ck_version}-bfs-406-413.patch"

bfq_version="v3r4"
bfq_url="http://algo.ing.unimo.it/people/paolo/disk_sched"
bfq_src="${bfq_url}/patches/${FULL_VERSION}-${bfq_version}/0001-block-prepare-I-O-context-code-for-BFQ-${bfq_version}-for-${BASE_VERSION}.patch
	${bfq_url}/patches/${FULL_VERSION}-${bfq_version}/0002-block-cgroups-kconfig-build-bits-for-BFQ-${bfq_version}-${BASE_VERSION}.patch
	${bfq_url}/patches/${FULL_VERSION}-${bfq_version}/0003-block-introduce-the-BFQ-${bfq_version}-I-O-sched-for-${BASE_VERSION}.patch"
use bfq && BFQ_PATCHES="${DISTDIR}/0001-block-prepare-I-O-context-code-for-BFQ-${bfq_version}-for-${BASE_VERSION}.patch
	${DISTDIR}/0002-block-cgroups-kconfig-build-bits-for-BFQ-${bfq_version}-${BASE_VERSION}.patch
	${DISTDIR}/0003-block-introduce-the-BFQ-${bfq_version}-I-O-sched-for-${BASE_VERSION}.patch:1"

fbcondecor_version="0.9.6"
fbcondecor_url="http://dev.gentoo.org/~mpagano/genpatches"
fbcondecor_src="${fbcondecor_url}/trunk/${BASE_VERSION}/4200_fbcondecor-${fbcondecor_version}.patch"
use fbcondecor && FBCONDECOR_PATCHES="${DISTDIR}/4200_fbcondecor-${fbcondecor_version}.patch"

uksm_version="0.1.1.2"
uksm_url="http://kerneldedup.org"
uksm_src="${uksm_url}/download/uksm/${uksm_version}/uksm-${uksm_version}-for-v${BASE_VERSION}.ge.34.patch"
use uksm && UKSM_PATCHES="${FILESDIR}/uksm-patch-fix.patch
	${DISTDIR}/uksm-${uksm_version}-for-v${BASE_VERSION}.ge.34.patch"

IUSE="+ck bfq fbcondecor +uksm +urwlocks"
DESCRIPTION="Full sources for the Linux kernel including: ck, bfq and other patches"
HOMEPAGE="http://www.kernel.org ${ck_url} ${bfq_url} ${fbcondecor_url} ${uksm_src} ${urwlocks_src}"
SRC_URI="${KERNEL_URI} ${ARCH_URI}
	ck?		( ${ck_src} )
	bfq?		( ${bfq_src} )
	fbcondecor?	( ${fbcondecor_src} )
	uksm?		( ${uksm_src} )"

KEYWORDS="~amd64 ~x86"
RDEPEND=">=sys-devel/gcc-4.5"

KV_FULL="${PVR}-lts-ck"
SLOT="${PV}"
S="${WORKDIR}/linux-${KV_FULL}"

UNIPATCH_LIST="${CK_PATCHES} ${BFQ_PATCHES} ${FBCONDECOR_PATCHES} ${UKSM_PATCHES} ${URWLOCKS_PATCHES}
	${FILESDIR}/enable-scsi-wait-scan-symbol.patch"
UNIPATCH_STRICTORDER="yes"

src_unpack() {
	kernel-2_src_unpack

	# Comment out EXTRAVERSION added by CK patch:
	sed -i -e 's/\(^EXTRAVERSION :=.*$\)/# \1/' "${S}/Makefile"

	rm -rf ${S}/Documentation/* && touch ${S}/Documentation/Makefile
	rm -rf ${S}/drivers/video/logo/* && touch ${S}/drivers/video/logo/{Makefile,Kconfig}
}
