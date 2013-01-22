# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games

MY_PN=${PN/handheld-quake-bin/handheld_quake}

DESCRIPTION="Handheld Quake (aka HQ) is a simulator of soviet, russian and
foreign handheld games."
HOMEPAGE="http://www.emulator3000.org/hq.htm"
SRC_URI="http://www.emulator3000.org/HandheldQuake/${MY_PN}_linux.zip"

S="${WORKDIR}"

LICENSE="FREEWARE"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/gtk+"
RDEPEND="${DEPEND}"

INSTALL_BASE="/opt/games/${PN}"
INSOPTIONS="-ggames"

src_prepare() {
    :
}

src_configure() {
    :
}

src_compile() {
    :
}

src_install() {
	dodoc Eng.Readme.txt || die
	insinto ${INSTALL_BASE}
	doins -r Games || die
	doins -r Base || die
	doins HandheldQuake || die
	dosym ${INSTALL_BASE}/HandheldQuake /usr/games/bin/HandheldQuake || die
}
