# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="An open source project to provide push notification support for Android -- a xmpp based notification server"
HOMEPAGE="http://sourceforge.net/projects/androidpn/"
SRC_URI="mirror://sourceforge/androidpn/${P}-bin.zip"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=virtual/jre-1.7"
RDEPEND=">=virtual/jdk-1.7
	${DEPEND}"

src_install() {
	insinto "/opt/${PN}/conf"
	doins -r conf/*  || die
	insinto "/opt/${PN}/console"
	doins -r console/*  || die
	insinto "/opt/${PN}/lib"
	doins lib/* || die
	dodir "/opt/${PN}/logs"
	doinitd "${FILESDIR}/androidpn" || die
}
