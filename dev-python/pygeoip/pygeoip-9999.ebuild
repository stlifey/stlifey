# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} )

inherit distutils-r1 git-2

DESCRIPTION="Pure Python API for Maxmind's binary GeoIP databases."
HOMEPAGE="https://github.com/appliedsec/pygeoip"
EGIT_REPO_URI="git://github.com/appliedsec/pygeoip.git"
SRC_URI=""

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
