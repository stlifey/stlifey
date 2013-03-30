# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

XORG_DOC=doc
XORG_MULTILIB=yes
inherit xorg-2 toolchain-funcs flag-o-matic

DESCRIPTION="X.Org X11 library"

KEYWORDS="~amd64 ~x86"
IUSE="ipv6 test"

RDEPEND=">=x11-libs/libxcb-1.8.1[${MULTILIB_USEDEP}]
	x11-libs/xtrans
	>=x11-proto/xproto-7.0.17[${MULTILIB_USEDEP}]
	x11-proto/xf86bigfontproto[${MULTILIB_USEDEP}]
	x11-proto/inputproto[${MULTILIB_USEDEP}]
	x11-proto/kbproto[${MULTILIB_USEDEP}]
	x11-proto/xextproto[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-lang/perl )"

PATCHES=(
	"${FILESDIR}"/${PN}-1.1.4-aix-pthread.patch
	"${FILESDIR}"/${PN}-1.1.5-winnt-private.patch
	"${FILESDIR}"/${PN}-1.1.5-solaris.patch
	"${FILESDIR}"/fix-timestamp-in-XNextEvent.patch
)

pkg_setup() {
	xorg-2_pkg_setup
	XORG_CONFIGURE_OPTIONS=(
		$(use_with doc xmlto)
		$(use_enable doc specs)
		$(use_enable ipv6)
		--without-fop
	)
}

src_configure() {
	[[ ${CHOST} == *-interix* ]] && export ac_cv_func_poll=no
	xorg-2_src_configure
}

src_compile() {
	# [Cross-Compile Love] Disable {C,LD}FLAGS and redefine CC= for 'makekeys'
	if tc-is-cross-compiler; then
		(
			filter-flags -m*
			emake -C "${AUTOTOOLS_BUILD_DIR}"/src/util CC=$(tc-getBUILD_CC) CFLAGS="${CFLAGS}" LDFLAGS="" clean all || die
		)
	fi
	xorg-2_src_compile
}
