# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND=2

inherit python git-2

DESCRIPTION="A GAE proxy forked from gappproxy/wallproxy"
HOMEPAGE="https://github.com/goagent/goagent"

EGIT_REPO_URI="git://github.com/goagent/goagent.git"
EGIT_BRANCH="2.0"

LICENSE="GPL-3"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-lang/python:2.7[ssl]
	dev-python/gevent
	dev-python/pyopenssl
"

src_unpack() {
	git-2_src_unpack
}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r $(python_get_version) .
}

src_install() {
	insinto /etc/goagent
	newins ${S}/local/proxy.ini proxy.ini

	insinto /opt/goagent
	doins local/proxy.{py,ini}
	
	newinitd ${FILESDIR}/goagent-initd goagent
	dosym /etc/goagent/proxy.ini /opt/goagent/proxy.ini
}

pkg_postrm() {
	echo
	ewarn "Note: Even though you have successfully unmerged GoAgent,"
	ewarn "certs file ( ${ROOT}opt/goagent/certs directory and ${ROOT}opt/goagent/CA.* )"
	ewarn "will remain behind."
	echo
}
