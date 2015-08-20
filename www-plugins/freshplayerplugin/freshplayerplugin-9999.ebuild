# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit git-2 cmake-utils

DESCRIPTION="Chromium Flash wrapper for Mozilla Firefox"
HOMEPAGE="https://github.com/i-rinat/freshplayerplugin"
SRC_URI=""
EGIT_REPO_URI="https://github.com/i-rinat/${PN}.git"
#EGIT_MASTER="master"
#EGIT_COMMIT="d1c43279020762f4d67beb1b206d6fb9e77c2289"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/glib
	dev-libs/libconfig
	dev-libs/libevent[threads]
	dev-libs/uriparser
	dev-util/ragel
	media-libs/libv4l
	media-libs/alsa-lib
	media-libs/freetype
	media-libs/mesa[egl,gles2]
	x11-libs/cairo
	x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/libXinerama
	x11-libs/pango
"

src_install() {
	insinto /etc
	newins data/freshwrapper.conf.example freshwrapper.conf

	insinto /usr/lib/nsbrowser/plugins/
	doins "${BUILD_DIR}"/libfreshwrapper-pepperflash.so
}
