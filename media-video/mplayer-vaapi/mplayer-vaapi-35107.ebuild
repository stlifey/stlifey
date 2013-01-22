# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="mplayer with VA-API support"
HOMEPAGE="http://gitorious.org/vaapi/mplayer"
SRC_URI="http://pkgbuild.com/~foutrelis/${P}.tar.xz"
  
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
   
DEPEND="
	x11-libs/libva
"
RDEPEND="${DEPEND}"

src_configure() {
	./configure
}

src_install() {
	dobin mplayer
	dosym /usr/bin/mplayer /usr/bin/${PN}
}