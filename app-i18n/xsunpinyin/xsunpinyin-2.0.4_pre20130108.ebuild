# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="The SunPinyin IMEngine Wrapper for XIM Framework"
HOMEPAGE="https://sunpinyin.googlecode.com/"
SRC_URI="http://dev.gentoo.org/~yngwin/distfiles/sunpinyin-${PV}.tar.xz"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	~app-i18n/sunpinyin-${PV}:=
	x11-libs/gtk+:2
	x11-libs/libX11
"

RDEPEND="${DEPEND}"

src_unpack() {
	default
	mv "${WORKDIR}/sunpinyin-${PV}" "${S}" || die
}

src_configure() {
	tc-export CXX
	myesconsargs=( --prefix="${EPREFIX}/usr" )
}

src_compile() {
	pushd "${S}"/wrapper/xim
	escons
	popd
}

src_install() {
	pushd "${S}"/wrapper/xim
	escons --install-sandbox="${D}" install
	popd

	dodir /etc/X11/xinit/xinitrc.d/
	XINITRCFCITX="${D}/etc/X11/xinit/xinitrc.d/01-input"

	echo "#! /bin/bash"  > "${XINITRCFCITX}"
	echo "export LANG=en_US.UTF-8"  >> "${XINITRCFCITX}"
	echo "export LC_ALL=en_US.UTF-8"  >> "${XINITRCFCITX}"
	echo "export XMODIFIERS=\"@im=xsunpinyin\""  >> "${XINITRCFCITX}"
	echo "export GTK_IM_MODULE=xim" >> "${XINITRCFCITX}"
	
	chmod 0755 "${XINITRCFCITX}"
}
