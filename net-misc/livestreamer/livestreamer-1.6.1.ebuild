# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

SRC_URI="https://github.com/chrippa/livestreamer/archive/v${PV}.tar.gz -> ${P}.tar.gz"

PYTHON_DEPEND="2:2.7 3:3.2"
inherit distutils

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	>=dev-python/requests-1.0
        <dev-python/requests-2.0
	dev-python/pbs
"

DEPEND="
	${RDEPEND}
	dev-python/setuptools
"
