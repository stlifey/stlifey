# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
ETYPE="sources"

ck_version="1"
bfq_version="5r1"

bfq_kernel_version="3.7.0"
cjktty_kernel_version="3.7.0"

SUPPORTED_USE="ck bfq cjktty"
DESCRIPTION="Full sources for the Linux kernel including: ck, bfq and other patches"
KEYWORDS="~amd64 ~x86"

inherit e-sources
