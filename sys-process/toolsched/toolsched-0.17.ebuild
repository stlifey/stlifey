# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Simple scripts for automatically starting commands"
HOMEPAGE="http://ck.kolivas.org/apps/toolsched/"
SRC_URI="
	${HOMEPAGE}/${P}/${PN}.b
	${HOMEPAGE}/${P}/${PN}.d
	${HOMEPAGE}/${P}/${PN}.i
	${HOMEPAGE}/${P}/${PN}.n
"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-process/schedtool"

src_unpack() { :; }

src_install() {
	dobin ${DISTDIR}/${PN}.*
}
