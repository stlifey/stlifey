# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2 python

EGIT_REPO_URI="git://github.com/goagent/goagent.git"
EGIT_BRANCH="3.0"

DESCRIPTION="A GAE proxy forked from gappproxy/wallproxy"
HOMEPAGE="http://code.google.com/p/goagent"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-lang/python:2.7[ssl]
	dev-libs/nss[utils]
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
	python_convert_shebangs -r $(python_get_version) local/proxy.py

	sed -e 's|^ geoip = .*)\( if.*\)$| geoip = pygeoip.GeoIP("/usr/share/GeoIP/GeoIP.dat")\1|' \
	-i ${S}/local/proxy.py

	sed -i -e 's/appid\ =\ goagent/appid\ =\ gastlifey/' local/proxy.ini
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
