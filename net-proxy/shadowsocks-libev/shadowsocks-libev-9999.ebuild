# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="A lightweight secured scoks5 proxy for embedded devices and low end boxes"
HOMEPAGE="https://github.com/shadowsocks/shadowsocks-libev"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/shadowsocks/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/shadowsocks/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE="debug +openssl polarssl systemd"

DEPEND="
	dev-libs/libev
	openssl? ( dev-libs/openssl )
	polarssl? ( net-libs/polarssl )
	systemd? ( sys-apps/systemd )
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
}
