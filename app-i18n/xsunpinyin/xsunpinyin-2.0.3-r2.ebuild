# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
inherit eutils scons-utils

DESCRIPTION="The SunPinyin IMEngine Wrapper for XIM Framework"
HOMEPAGE="http://sunpinyin.googlecode.com"
SRC_URI="${HOMEPAGE}/files/${P}.tar.gz"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-i18n/sunpinyin
		x11-libs/gtk+:2
		x11-libs/libX11"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}"
	epatch "${FILESDIR}/${P}-force-switch.patch"
	epatch "${FILESDIR}/${P}-colormap-assertion.patch"
	epatch "${FILESDIR}/${P}-preferences-button-assertion.patch"
}

src_compile() {
	escons --prefix="/usr" || die
}

src_install() {
	escons --prefix="/usr" --install-sandbox="${D}" install || die

	dodir /etc/X11/xinit/xinitrc.d/

	XINITRCFCITX="${D}/etc/X11/xinit/xinitrc.d/01-input"

	echo "#! /bin/bash"  > "${XINITRCFCITX}"

	echo "export LANG=en_US.UTF-8"  >> "${XINITRCFCITX}"
	echo "export LC_ALL=en_US.UTF-8"  >> "${XINITRCFCITX}"

	echo "export XMODIFIERS=\"@im=xsunpinyin\""  >> "${XINITRCFCITX}"
	echo "export GTK_IM_MODULE=xim" >> "${XINITRCFCITX}"
	
	chmod 0755 "${XINITRCFCITX}"
}
