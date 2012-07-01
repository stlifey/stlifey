# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit prefix

DESCRIPTION="Simple scripts for automatically starting commands"
HOMEPAGE="http://ck.kolivas.org/apps/toolsched/"
SRC_URI="http://ck.kolivas.org/apps/toolsched/toolsched-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris"
IUSE=""

RDEPEND="sys-process/schedtool"

src_install() {
	mkdir -p "${D}"/usr/bin
	install -c -D ${WORKDIR}/toolsched-${PV}/toolsched.* "${D}"/usr/bin
}
