# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 

DESCRIPTION="Pidgin plugin to disable keepalives (protocol pings) on a per-account basis"
HOMEPAGE="https://github.com/EionRobb/pidgin-no-keepalives"
EGIT_REPO_URI="https://github.com/EionRobb/pidgin-no-keepalives.git"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT="0"
SRC_URI=""

RDEPEND="net-im/pidgin"

DEPEND="${RDEPEND}
		>dev-libs/glib-2.0"

src_compile() {
	GLIB_CFLAGS="-I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include
	-I/usr/include"
	LIBPURPLE_CFLAGS="-I/usr/include/libpurple -DPURPLE_PLUGINS"

	CFLAGS="${CFLAGS} ${LIBPURPLE_CFLAGS} -Wall -pthread ${GLIB_CFLAGS} -I.
	-shared -fPIC -DPIC"

	if use amd64; then
		CFLAGS="${CFLAGS} -m32 -m64"
	fi

	cc ${CFLAGS} -o no_keepalives.so no_keepalives.c || die 'Error compiling library!'

}

src_install() {
	insinto /usr/lib/purple-2
	doins "no_keepalives.so"
}
