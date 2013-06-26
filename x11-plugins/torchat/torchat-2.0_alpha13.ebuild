# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit versionator vcs-snapshot multilib

MY_PV=$(version_format_string '$1.$2-${3/alpha/alpha-}')

DESCRIPTION="Pidgin plugin for p2p instant messaging through Tor hidden service tunnels "
HOMEPAGE="https://github.com/prof7bit/TorChat"
SRC_URI="https://github.com/prof7bit/TorChat/tarball/${MY_PV} -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="net-im/pidgin
	net-misc/tor"
DEPEND=">=dev-lang/fpc-2.6.0"

src_install(){
	insinto "/usr/$(get_libdir)/purple-2"
	doins bin/libpurpletorchat.so
	dodoc README.markdown
}
