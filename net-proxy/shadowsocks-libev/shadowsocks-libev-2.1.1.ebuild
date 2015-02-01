# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/shadowsocks-libev/shadowsocks-libev-2.0.4.ebuild,v 1.1 2015/01/11 14:02:48 dlan Exp $

EAPI=5

inherit eutils

DESCRIPTION="A lightweight secured scoks5 proxy for embedded devices and low end boxes"
HOMEPAGE="https://github.com/shadowsocks/shadowsocks-libev"

MY_PV="v${PV}"
SRC_URI="
	https://github.com/shadowsocks/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
	https://raw.githubusercontent.com/shadowsocks/shadowsocks-libev/master/acl/chn.acl
"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +openssl polarssl"

DEPEND="openssl? ( dev-libs/openssl )
	polarssl? ( net-libs/polarssl )
	"
RDEPEND="${DEPEND}"

REQUIRED_USE=" ^^ ( openssl polarssl )"

src_configure() {
	econf \
		$(use_enable debug assert) \
		--with-crypto-library=$(usex openssl openssl polarssl)
}

src_install() {
	default
	prune_libtool_files --all

	insinto "/etc/"
	newins "${DISTDIR}/chn.acl" ss.chn.acl
}
