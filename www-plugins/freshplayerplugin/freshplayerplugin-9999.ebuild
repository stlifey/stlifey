# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-2

DESCRIPTION="PPAPI to NPAPI plugins compatibility layer."
HOMEPAGE="https://github.com/i-rinat/freshplayerplugin"
EGIT_REPO_URI="git://github.com/i-rinat/freshplayerplugin.git"

LICENSE="LGPL-3"
SLOT="0"

RDEPEND="
	dev-libs/uriparser
	www-plugins/chrome-binary-plugins[flash]
"
DEPEND="${RDEPEND}"

KEYWORDS="~amd64 ~x86"

src_install() {
	einfo ""
}
