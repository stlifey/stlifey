# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="1"

ck_version="1"
fbcondecor_version="0.9.6"
gentoo_version="13"
optimization_version="2"
tuxonice_version="2013.06.08"
uksm_version="0.1.2.2"

aufs_kernel_version="3.9_p20130520"
cjktty_kernel_version="3.8.1"
imq_kernel_version="3.9.0"
reiser4_kernel_version="3.9.2"
tuxonice_kernel_version="3.9.5"
uksm_kernel_version="3.9.1"

KEYWORDS="~amd64 ~x86"

SUPPORTED_USE="+aufs +cjktty +ck +gentoo +imq +optimization +reiser4 +tuxonice +uksm"

CK_PRE_PATCH=""
CK_POST_PATCH=""
UNIPATCH_EXCLUDE=""

OVERRIDE_AUFS_PATCHES=""
OVERRIDE_BFQ_PATCHES=""
OVERRIDE_CJKTTY_PATCHES=""
OVERRIDE_CK_PATCHES=""
OVERRIDE_FBCONDECOR_PATCHES=""
OVERRIDE_IMQ_PATCHES="${FILESDIR}/patch-imqmq-${imq_kernel_version/.0/}.diff.xz"
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

ADDITION_PATCHES="${FILESDIR}/enable-ivb-pstate.patch"

inherit e-sources
