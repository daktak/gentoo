# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Twitux it's a free and open source GTK+ application for Twitter.com"
HOMEPAGE="http://sourceforge.net/projects/twitux"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-libs/libsexy
		>=x11-libs/gtk+-2.14.0:2
		>=dev-libs/glib-2.15.0
		>=media-libs/libcanberra-0.4[gtk]
		net-libs/libsoup
		x11-libs/libnotify
		dev-libs/dbus-glib"
RDEPEND="${DEPEND}"

src_prepare () {
	epatch ${FILESDIR}/"${P}"-notify.patch || die
}
