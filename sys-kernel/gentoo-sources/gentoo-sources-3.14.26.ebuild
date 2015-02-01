# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="1"

ck_version="1"
gentoo_version="31"
tuxonice_version="2014.08.07"
uksm_version="0.1.2.3"

aufs_kernel_version="3.14.21+_p20141208"
reiser4_kernel_version=""
tuxonice_kernel_version="3.14.15"
uksm_kernel_version=""

KEYWORDS="x86 amd64 mips"

SUPPORTED_USE="+additional +aufs +ck +exfat +experimental +gentoo +thinkpad +tuxonice"

UNIPATCH_EXCLUDE=""

OVERRIDE_AUFS_PATCHES=""
OVERRIDE_CK_PATCHES=""
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
