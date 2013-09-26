# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="1"

ck_version="1"
gentoo_version="19"
optimization_version="2"
tuxonice_version="2013.09.22"
uksm_version="0.1.2.2"

aufs_kernel_version="3.10_p20130915"
cjktty_kernel_version="3.8.1"
imq_kernel_version="3.10.0"
reiser4_kernel_version="3.10.0"
tuxonice_kernel_version="3.10.12"
uksm_kernel_version="3.10.0"

KEYWORDS="~amd64 ~x86"

SUPPORTED_USE="+additional +aufs +cjktty +ck +imq +gentoo +experimental +optimization +reiser4 +tuxonice +uksm"

UNIPATCH_EXCLUDE=""

OVERRIDE_CJKTTY_PATCHES="0"
OVERRIDE_CK_PATCHES="0"
OVERRIDE_IMQ_PATCHES="1"
OVERRIDE_REISER4_PATCHES="0"
OVERRIDE_TUXONICE_PATCHES="0"
OVERRIDE_UKSM_PATCHES="0"

inherit e-sources
