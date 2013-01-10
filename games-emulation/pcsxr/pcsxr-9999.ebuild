# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

ESVN_REPO_URI="https://pcsxr.svn.codeplex.com/svn/pcsxr"
ESVN_PROJECT="pcsxr"
ESVN_REVISION="80393"

inherit eutils autotools games subversion

DESCRIPTION="PCSX-Reloaded: a fork of PCSX, the discontinued Playstation emulator"
HOMEPAGE="http://pcsxr.codeplex.com"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="alsa cdio openal opengl oss pulseaudio +sdl-sound"

RDEPEND="
	x11-libs/gtk+:2
	gnome-base/libglade
	media-libs/libsdl
	sys-libs/zlib
	app-arch/bzip2
	x11-libs/libXv
	x11-libs/libXtst
	alsa? ( media-libs/alsa-lib )
	openal? ( media-libs/openal )
	opengl? ( virtual/opengl
	x11-libs/libXxf86vm )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.16 )
	cdio? ( dev-libs/libcdio )
"

DEPEND="
	${RDEPEND}
	!games-emulation/pcsx
	!games-emulation/pcsx-df
	x86? ( dev-lang/nasm )
"

pkg_setup() {
	if use alsa; then
		sound_backend="alsa"
	elif use pulseaudio; then
		sound_backend="pulseaudio"
	elif use oss; then
		sound_backend="oss"
	elif use openal; then
		sound_backend="openal"
	elif use sdl-sound; then
		sound_backend="sdl"
	else
		sound_backend="null"
	fi

	elog "Using ${sound_backend} sound"
	games_pkg_setup
}

src_prepare() {
	# fix plugin path
	for i in $(grep -irl 'games/psemu' *);
	do
		sed -i "$i" \
		-e "s:games/psemu:psemu:g" \
		|| die "sed failed"
	done

	# fix icon and .desktop path
	epatch "${FILESDIR}/${P}-datadir.patch"

	epatch "${FILESDIR}/${P}-remove-icon.patch"

	# regenerate for changes to spread
	eautoreconf
}

src_configure() {
	egamesconf \
		$(use_enable cdio libcdio) \
		$(use_enable opengl) \
		--enable-sound=${sound_backend} \
		|| die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install \
	    || die "emake install failed"

	rm -rf ${D}/usr/share/games/pcsxr/*.png

	cp "${FILESDIR}/pcsxr.glade2" ${D}/usr/share/games/pcsxr/

	dodoc README doc/keys.txt doc/tweaks.txt ChangeLog
	prepgamesdirs
}
