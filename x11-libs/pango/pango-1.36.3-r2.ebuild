# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2 multilib toolchain-funcs multilib-minimal

DESCRIPTION="Internationalized text layout and rendering library"
HOMEPAGE="http://www.pango.org/"

LICENSE="LGPL-2+ FTL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"

IUSE="X +introspection"

RDEPEND="
	>=media-libs/harfbuzz-0.9.9:=[glib(+),truetype(+),${MULTILIB_USEDEP}]
	>=dev-libs/glib-2.33.12:2[${MULTILIB_USEDEP}]
	>=media-libs/fontconfig-2.10.91:1.0=[${MULTILIB_USEDEP}]
	media-libs/freetype:2=[${MULTILIB_USEDEP}]
	>=x11-libs/cairo-1.12.10:=[X?,${MULTILIB_USEDEP}]
	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )
	X? (
		x11-libs/libXrender[${MULTILIB_USEDEP}]
		x11-libs/libX11[${MULTILIB_USEDEP}]
		>=x11-libs/libXft-2.0.0[${MULTILIB_USEDEP}]
	)
	abi_x86_32? (
		!<=app-emulation/emul-linux-x86-gtklibs-20131008-r3
		!app-emulation/emul-linux-x86-gtklibs[-abi_x86_32(-)]
	)
"

DEPEND="
	${RDEPEND}
	>=dev-util/gtk-doc-am-1.15
	virtual/pkgconfig
	X? ( x11-proto/xproto[${MULTILIB_USEDEP}] )
	!<=sys-devel/autoconf-2.63:2.5
"

MULTILIB_CHOST_TOOLS=(
	/usr/bin/pango-querymodules
)

src_prepare() {
	epatch_user
	eautoreconf

	gnome2_src_prepare
}

multilib_src_configure() {
	tc-export CXX

	ECONF_SOURCE=${S} \
	gnome2_src_configure \
		--with-cairo \
		$(multilib_build_binaries \
			&& use_enable introspection \
			|| echo --disable-introspection) \
		$(use_with X xft) \
		"$(usex X --x-includes="${EPREFIX}/usr/include" "")" \
		"$(usex X --x-libraries="${EPREFIX}/usr/$(get_libdir)" "")"
}

multilib_src_install() {
	gnome2_src_install

	local PANGO_CONFDIR="/etc/pango/${CHOST}"
	dodir "${PANGO_CONFDIR}"
	keepdir "${PANGO_CONFDIR}"
}

pkg_postinst() {
	gnome2_pkg_postinst

	multilib_pkg_postinst() {
		einfo "Generating modules listing..."
		local PANGO_CONFDIR="${EROOT}/etc/pango/${CHOST}"
		local pango_conf="${PANGO_CONFDIR}/pango.modules"
		local tmp_file=$(mktemp -t tmp_pango_ebuild.XXXXXXXXXX)
		local querymodules
		if [[ ${#MULTIBUILD_VARIANTS[@]} -gt 1 ]]; then
			querymodules="${CHOST}-pango-querymodules"
		else
			querymodules="pango-querymodules"
		fi

		# be atomic!
		if "${querymodules}" --system \
			"${EROOT}"usr/$(get_libdir)/pango/1.8.0/modules/*$(get_modname) \
				> "${tmp_file}"; then
			cat "${tmp_file}" > "${pango_conf}" || {
				rm "${tmp_file}"; die; }
		else
			ewarn "Cannot update pango.modules, file generation failed"
		fi
		rm "${tmp_file}"
	}
	multilib_foreach_abi multilib_pkg_postinst

	if [[ ${REPLACING_VERSIONS} < 1.30.1 ]]; then
		elog "In >=${PN}-1.30.1, default configuration file locations moved from"
		elog "~/.pangorc and ~/.pangox_aliases to ~/.config/pango/pangorc and"
		elog "~/.config/pango/pangox.aliases"
	fi
}
