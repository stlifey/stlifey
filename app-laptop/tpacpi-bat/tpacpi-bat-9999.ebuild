# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

if [ "${PV}" = "9999" ]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/teleshoes/tpacpi-bat.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="mirror://github/teleshoes/tpacpi-bat/tarball/v${PV} -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi
DESCRIPTION="Control battery thresholds of recent ThinkPads, which are not supported by tp_smapi"
HOMEPAGE="https://github.com/teleshoes/tpacpi-bat"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	sys-power/acpi_call
	dev-lang/perl
"
DEPEND="
	${RDEPEND}
"

src_prepare() {
	epatch_user
}

src_install() {
	dodoc README battery_asl
	dobin tpacpi-bat
	newinitd "${FILESDIR}"/${PN}.initd.0 ${PN}
	newconfd "${FILESDIR}"/${PN}.confd.0 ${PN}
}
