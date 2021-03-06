# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4
inherit gnome2-utils

URELEASE="raring"
UVER=""

DESCRIPTION="A nice and well polished icon theme"
HOMEPAGE="http://packages.ubuntu.com/raring/human-icon-theme"
SRC_URI="mirror://ubuntu/pool/main/h/${PN}/${PN}_${PV}.tar.gz"

LICENSE="CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

src_install() {
	insinto /usr/share/icons
	doins -r Humanity
	doins -r Humanity-Dark

	## Remove broken symlinks ##
	find -L "${ED}" -type l -exec rm {} +
}
