# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils autotools

DESCRIPTION="Shadowsocks is a lightweight secured scoks5 proxy for embedded devices and low end boxes"
HOMEPAGE="https://github.com/shadowsocks/shadowsocks-libev"

MY_PV="v${PV}"
SRC_URI="https://github.com/shadowsocks/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="debug"

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable debug assert)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	insinto "/etc/"
	newins "${FILESDIR}/shadowsocks.json" shadowsocks.json

	newinitd "${FILESDIR}/ss-local-initd" ss-local
	newinitd "${FILESDIR}/ss-server-initd" ss-server
}
