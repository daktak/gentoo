# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit toolchain-funcs

DESCRIPTION="Utility to initiate bluetooth pairing with a PS3 controller"
HOMEPAGE="http://www.pabr.org/sixlinux/sixlinux.en.html"
SRC_URI="http://www.pabr.org/sixlinux/sixpair.c -> ${P}.c"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/libusb:0"
RDEPEND="${DEPEND}
	net-wireless/bluez"

S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}/${P}.c" sixpair.c || die
}

src_compile() {
	local args="$(tc-getCC) ${CFLAGS} ${CPPFLAGS} ${LDFLAGS} sixpair.c -lusb -o sixpair"
	echo "${args}"
	${args} || die
}

src_install() {
	dobin sixpair
}
