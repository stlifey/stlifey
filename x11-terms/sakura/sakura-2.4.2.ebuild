# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

inherit cmake-utils eutils

DESCRIPTION="sakura is a terminal emulator based on GTK and VTE"
HOMEPAGE="http://www.pleyades.net/david/projects/sakura/"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
LANGS=" ca cs de es fr hr hu it ja ko pl pt_BR ru zh_CN"
IUSE="${LANGS// / linguas_}"

RDEPEND="
	>=dev-libs/glib-2.20
	>=x11-libs/gtk+-2.16:2
	>=x11-libs/vte-0.26:0
"
DEPEND="
	${RDEPEND}
	>=dev-lang/perl-5.10.1
	virtual/pkgconfig
"

DOCS="AUTHORS INSTALL"

src_prepare() {
	epatch_user

	sed -i -e "/FILES INSTALL/d" CMakeLists.txt || die

	for lang in ${LANGS}; do
		if ! use linguas_${lang}; then
			rm -f po/${lang}.po || die
		fi
	done

	cmake-utils_src_prepare
}
