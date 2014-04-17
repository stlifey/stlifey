# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="1"

ck_version="1"
gentoo_version="13"
tuxonice_version="2014.03.17"
uksm_version="0.1.2.2"

aufs_kernel_version="3.13_p20140310"
cjktty_kernel_version="3.11.0"
reiser4_kernel_version="3.13.6"
tuxonice_kernel_version="3.13.6"
uksm_kernel_version="3.13.9"

KEYWORDS="~amd64 ~x86 ~mips"

SUPPORTED_USE="+additional +aufs +ck +exfat +experimental +gentoo +imq +reiser4 +thinkpad +tuxonice +uksm"
UNSUPPORTED_USE=""

UNIPATCH_EXCLUDE=""

OVERRIDE_AUFS_PATCHES=""
OVERRIDE_CK_PATCHES=""
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
