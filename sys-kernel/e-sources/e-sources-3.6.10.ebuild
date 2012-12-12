# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
ETYPE="sources"

ck_version="1"
bfq_version="5"
reiser4_version="3.6.4"
fbcondecor_version="0.9.6"
uksm_main_version="0.1.2.1"
uksm_sub_version="2"

IUSE="+ck bfq fbcondecor reiser4 +uksm"
DESCRIPTION="Full sources for the Linux kernel including: ck, bfq and other patches"
KEYWORDS="~amd64 ~x86"

inherit stlifey
