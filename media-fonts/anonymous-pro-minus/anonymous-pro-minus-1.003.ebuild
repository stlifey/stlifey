# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit font

MY_PN="AnonymousProMinus"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Monospaced truetype font designed with coding in mind"
HOMEPAGE="http://www.ms-studio.com/FontSales/anonymouspro.html"
SRC_URI="http://www.marksimonson.com/assets/content/fonts/AnonymousProMinus-1.003.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

FONT_SUFFIX="ttf"
FONT_S="${WORKDIR}/${MY_P}"
DOCS="FONTLOG.txt README.txt"

S=${FONT_S}

# Only installs fonts.
RESTRICT="strip binchecks"
