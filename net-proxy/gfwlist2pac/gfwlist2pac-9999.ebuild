# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit eutils distutils-r1 git-2

DESCRIPTION="Convert GFWList into O(1) PAC file"
HOMEPAGE="https://github.com/clowwindy/gfwlist2pac"

EGIT_REPO_URI="git://github.com/clowwindy/gfwlist2pac.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
