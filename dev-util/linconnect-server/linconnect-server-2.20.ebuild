# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Mirror Android notifications on a Linux desktop"
HOMEPAGE="https://github.com/hauckwill/linconnect-server"
SRC_URI="https://github.com/hauckwill/${PN}/archive/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-lang/python:2.7
		net-dns/avahi
		dev-python/pygobject:2
		dev-python/pybonjour
		dev-python/cherrypy"
RDEPEND="${DEPEND}"

src_install() {
epatch ${FILESDIR}/${P}.patch || die
dobin LinConnectServer/main/linconnect_server.py || die
insinto /etc/xdg/autostart
doins ${FILESDIR}/${PN}.desktop
dodoc README.md
}

