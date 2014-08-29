# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="git://github.com/goagent/goagent.git"
	EGIT_BRANCH="3.0"
	GOAGENT_ECLASS="git-2"
	KEYWORDS="~amd64 ~x86"
else
	GOAGENT_SRC_URI="https://github.com/goagent/goagent/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	RESTRICT="mirror"
	GOAGENT_ECLASS="vcs-snapshot"
	KEYWORDS="~amd64 ~x86"
fi

inherit eutils ${GOAGENT_ECLASS}

DESCRIPTION="A GAE proxy forked from gappproxy/wallproxy"
HOMEPAGE="http://code.google.com/p/goagent"
SRC_URI="${GOAGENT_SRC_URI}"

LICENSE="GPL-3"
SLOT="3"

RDEPEND="
	dev-lang/python:2.7[ssl]
	dev-libs/geoip
	dev-libs/nss[utils]
	dev-python/dnslib
	dev-python/gevent
	dev-python/pycrypto
	dev-python/pygeoip
	dev-python/pyopenssl
	net-libs/pacparser
"

src_prepare() {
	epatch_user
}

src_unpack() {
	${GOAGENT_ECLASS}_src_unpack

	sed -e "s|^#!/usr/bin/env python|#!/usr/bin/env python2|" \
		-i local/{proxy.py,proxylib.py,dnsproxy.py}
}

src_install() {
	insinto "/etc/"
	newins "${FILESDIR}/goagent" goagent

	insinto /opt/goagent
	doins ${FILESDIR}/CA.crt
	doins local/cacert.pem
	doins local/proxy.{pac,py,ini}
	doins local/dnsproxy.py
	doins local/proxylib.py
	
	dodir /opt/goagent/certs
	newinitd ${FILESDIR}/goagent-initd goagent
	dosym /etc/goagent "/opt/goagent/proxy.user.ini"
}
