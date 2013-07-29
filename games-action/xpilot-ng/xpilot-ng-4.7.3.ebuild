# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/xpilot/xpilot-4.5.5.ebuild,v 1.3 2010/06/21 20:13:52 maekke Exp $

EAPI="5"

inherit eutils games

DESCRIPTION="Multi-player 2D spacewar game. Extended version of XPilot."
HOMEPAGE="http://xpilot.sourceforge.net/"
SRC_URI="mirror://sourceforge/xpilot/xpilot_ng/${P}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xproto
	x11-misc/gccmakedep
	x11-misc/imake
	app-text/rman"
