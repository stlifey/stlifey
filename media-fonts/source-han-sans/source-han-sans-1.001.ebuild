# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit font

MY_PN="SourceHanSans"
SRC_PREFIX="https://gentoo.org.cn/distfiles/${MY_PN}"
SRC_SUFFIX="-${PV}.tar.xz"

DESCRIPTION="Source Han Sans is an OpenType/CFF Pan-CJK font family."
HOMEPAGE="https://github.com/adobe-fonts/source-han-sans"

SRC_URI="otc? ( ${SRC_PREFIX}OTC${SRC_SUFFIX} )
	${SRC_PREFIX}CN${SRC_SUFFIX}
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc mips ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE="otc"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/"
FONT_S="${S}"

# Only installs fonts
RESTRICT="strip binchecks mirror"

src_prepare() {
	if use otc ; then
	mv -vf "${WORKDIR}/${MY_PN}OTC-${PV}/"* ${S} || die
	fi

	mv -vf "${WORKDIR}/${MY_PN}CN-${PV}/"* ${S} || die
}

src_install() {
	local has_linguas=false
	FONT_SUFFIX=""
	FONT_CONF=()
	if use otc ; then
		FONT_CONF+=(${FILESDIR}/81-source-han-sans-otc.conf)
		FONT_SUFFIX="${FONT_SUFFIX} ttc"
	fi

	FONT_CONF+=(${FILESDIR}/81-source-han-sans-cn.conf)
	has_linguas=true

	if [ $has_linguas = true ]; then
		FONT_SUFFIX="${FONT_SUFFIX} otf"
	fi

	font_src_install
}
