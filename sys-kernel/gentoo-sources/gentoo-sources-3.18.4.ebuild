# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="1"

ck_version="1"
gentoo_version="6"
tuxonice_version=""
uksm_version="0.1.2.3"

aufs_kernel_version=""
reiser4_kernel_version=""
tuxonice_kernel_version=""
uksm_kernel_version="3.18.0"

KEYWORDS="amd64 x86 mips"

SUPPORTED_USE="+additional +ck +experimental +gentoo +uksm +thinkpad"

UNIPATCH_EXCLUDE=""

OVERRIDE_AUFS_PATCHES=""
OVERRIDE_CK_PATCHES=""
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
