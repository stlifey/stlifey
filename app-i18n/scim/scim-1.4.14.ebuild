# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim/scim-1.4.14.ebuild,v 1.3 2012/09/15 12:41:47 naota Exp $

EAPI="4"
inherit eutils flag-o-matic multilib gnome2-utils autotools-utils

DESCRIPTION="Smart Common Input Method (SCIM) is an Input Method (IM) development platform"
HOMEPAGE="http://www.scim-im.org/"
SRC_URI="mirror://sourceforge/scim/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="doc gtk3"

RDEPEND="x11-libs/libX11
	dev-libs/glib:2
	gtk3? ( x11-libs/gtk+:3 )
	!gtk3? ( x11-libs/gtk+:2 )
	>=dev-libs/atk-1
	>=x11-libs/pango-1
	!app-i18n/scim-cvs"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen
		>=app-text/docbook-xsl-stylesheets-1.73.1 )
	dev-lang/perl
	virtual/pkgconfig
	>=dev-util/intltool-0.33
	sys-devel/libtool"
AUTOTOOLS_IN_SOURCE_BUILD=1
DOCS=(
	README
	AUTHORS
	ChangeLog
	docs/developers
	docs/scim.cfg
)

src_configure() {
	local gtk_version
	if use gtk3; then
		gtk_version="--with-gtk-version=3"
	else
		gtk_version="--with-gtk-version=2"
	fi

	# bug #83625
	filter-flags -fvisibility-inlines-hidden -fvisibility=hidden
	local myeconfargs=(
		$(use_with doc doxygen)
		--enable-ld-version-script
		$gtk_version
		--disable-setup-ui
		--disable-frontend-x11
		--disable-im-rawcode
	)
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile
	use doc && emake docs
}

src_install() {
	use doc && HTML_DOCS=("${AUTOTOOLS_BUILD_DIR}/docs/html/")
	autotools-utils_src_install

	sed -e "s:@EPREFIX@:${EPREFIX}:" "${FILESDIR}/xinput-${PN}" > "${T}/${PN}.conf" || die
	insinto /etc/X11/xinit/xinput.d
	doins "${T}/${PN}.conf"
}

pkg_postinst() {
	ewarn
	ewarn "If you upgraded from scim-1.2.x or scim-1.0.x, you should remerge all SCIM modules."
	ewarn

	gnome2_query_immodules_gtk2
}

pkg_postrm() {
	gnome2_query_immodules_gtk2
}
