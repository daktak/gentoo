# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 

DESCRIPTION="HTTP-based file sharing plugin for Pidgin"
HOMEPAGE="https://github.com/EionRobb/pidgin-http-ft"
EGIT_REPO_URI="https://github.com/EionRobb/pidgin-http-ft.git"
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

	cc ${CFLAGS} -o http_ft.so http_ft.c || die 'Error compiling library!'

}

src_install() {
	insinto /usr/lib/purple-2
	doins "http_ft.so"
}
