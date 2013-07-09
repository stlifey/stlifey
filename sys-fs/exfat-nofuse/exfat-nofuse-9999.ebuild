# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit linux-info linux-mod git-2

DESCRIPTION="A kernel module that enables you to call ACPI methods"
HOMEPAGE="https://github.com/rxrz/exfat-nofuse.git"

EGIT_REPO_URI="git://github.com/rxrz/exfat-nofuse.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CONFIG_CHECK="!USER_NS"
BUILD_TARGETS="all"
MODULE_NAMES="exfat_fs(fs:${S}) exfat_core(fs:${S})"

src_compile(){
	BUILD_PARAMS="KDIR=${KV_OUT_DIR} M=${S}"
	linux-mod_src_compile
}
