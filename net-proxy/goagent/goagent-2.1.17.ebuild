# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit python vcs-snapshot

DESCRIPTION="A GAE proxy forked from gappproxy/wallproxy"
HOMEPAGE="http://code.google.com/p/goagent"
SRC_URI="https://github.com/goagent/goagent/tarball/v${PV} -> ${P}.tar.gz"
RESTRICT="mirror"

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
	vcs-snapshot_src_unpack
}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r $(python_get_version) local/proxy.py
}

src_install() {
	insinto /etc/goagent
	newins ${S}/local/proxy.ini proxy.ini

	insinto /opt/goagent
	doins local/CA.crt
	doins local/cacert.pem
	doins local/proxy.{pac,py,ini}
	
	dodir /opt/goagent/certs
	newinitd ${FILESDIR}/goagent-initd goagent
	dosym /etc/goagent/proxy.ini /opt/goagent/proxy.ini
}
