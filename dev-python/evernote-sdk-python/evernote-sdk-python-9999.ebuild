# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit eutils distutils-r1 git-2

DESCRIPTION="Evernote SDK for Python"
HOMEPAGE="http://dev.evernote.com"

EGIT_REPO_URI="git://github.com/evernote/evernote-sdk-python.git"
EGIT_BRANCH="master"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/thrift[python]
	dev-python/oauth2
"

src_prepare() {
	rm -rf lib/thrift
}

src_install() {
	distutils-r1_src_install
}
