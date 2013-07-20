# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit nsplugins

DESCRIPTION="SA-iSecurity Plug-in for UMS"
HOMEPAGE="http://www.chinapay.com"
KEYWORDS="~amd64 ~x86"
SRC_URI="https://account.chinapay.com/person/setup/iSecurityUMS-linux.tar.gz"

LICENSE="unknown"
RESTRICT="strip mirror"
SLOT="0"
IUSE=""

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}-install

src_compile() {
	if use amd64; then
		tar xvzf ${S}/iSecurityUMS-linux-x86_64.tar.gz
	elif use x86; then
		tar xvzf ${S}/iSecurityUMS-linux-i686.tar.gz
	fi
}

src_install() {
	insinto "/opt/netscape/plugins"
	doins "${S}/iSecurityUMS.so"
	inst_plugin "/opt/netscape/plugins/iSecurityUMS.so"
}
