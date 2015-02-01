# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="1"

ck_version="2"
gentoo_version="9"
tuxonice_version="2014.08.07"
uksm_version="0.1.2.3"

aufs_kernel_version="3.16_p20141020"
reiser4_kernel_version="3.16.2"
tuxonice_kernel_version="3.16.0"
uksm_kernel_version="3.16.1"

KEYWORDS="amd64 x86 mips"

SUPPORTED_USE="+additional +aufs +ck +experimental +gentoo +reiser4 +uksm +thinkpad +tuxonice"

UNIPATCH_EXCLUDE=""

OVERRIDE_AUFS_PATCHES=""
OVERRIDE_CK_PATCHES=""
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
