# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Legacy (stable) release of the GTK+ 2.x based codebase"
HOMEPAGE="http://tarot.freeshell.org/leafpad/"
SRC_URI="mirror://nongnu/${PN}/${P}.tar.gz"

LICENSE=GPL-2
SLOT=0
KEYWORDS="amd64 x86"
IUSE=emacs

RDEPEND="
	virtual/libintl
	x11-libs/gtk+:2
"

DEPEND="
	${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	epatch_user
}

src_configure() {
	econf --enable-chooser --enable-print $(use_enable emacs)
}
