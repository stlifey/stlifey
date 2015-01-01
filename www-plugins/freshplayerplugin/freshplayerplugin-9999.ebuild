# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit git-2 cmake-utils

DESCRIPTION="Chromium Flash wrapper for Mozilla Firefox"
HOMEPAGE="https://github.com/i-rinat/freshplayerplugin"
SRC_URI=""
EGIT_REPO_URI="https://github.com/i-rinat/${PN}.git"
#EGIT_COMMIT="9ae7a650f4f57b09069b58d93c339dbd6d2202ac"

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
