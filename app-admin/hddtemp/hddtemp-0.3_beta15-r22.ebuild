# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools

MY_P=${P/_beta/-beta}

DESCRIPTION="A simple utility to read the temperature of SMART capable hard drives"
HOMEPAGE="http://savannah.nongnu.org/projects/hddtemp/"
SRC_URI="http://download.savannah.gnu.org/releases/hddtemp/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="network-cron nls"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS=(README TODO ChangeLog)

src_prepare() {
	epatch "${FILESDIR}"/${P}-satacmds.patch
	epatch "${FILESDIR}"/${P}-byteswap.patch
	epatch "${FILESDIR}"/${P}-execinfo.patch
	epatch "${FILESDIR}"/${P}-nls.patch
	epatch "${FILESDIR}"/${P}-iconv.patch
	epatch "${FILESDIR}"/${P}-dontwake.patch
	AT_M4DIR="m4" eautoreconf
}

src_configure() {
	local myconf

	myconf="--with-db-path=/usr/share/hddtemp/hddtemp.db"
	# disabling nls breaks compiling
	use nls || myconf="--disable-nls ${myconf}"
	econf ${myconf}
}

src_install() {
	default

	insinto /usr/share/hddtemp
	newins "${FILESDIR}/hddgentoo.db" hddtemp.db
	doins "${FILESDIR}"/hddgentoo.db

	newconfd "${FILESDIR}"/hddtemp-conf.d hddtemp
	newinitd "${FILESDIR}"/hddtemp-init hddtemp
}
