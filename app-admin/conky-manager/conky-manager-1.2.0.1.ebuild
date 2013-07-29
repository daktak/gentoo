# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="A simple GUI for managing Conky config files"
HOMEPAGE="https://launchpad.net/conky-manager"
SRC_URI="http://ppa.launchpad.net/teejee2008/ppa/ubuntu/pool/main/c/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/vala-0.18
	    <dev-lang/vala-0.19
		app-admin/conky
		>=x11-libs/gtk+-3.0
		app-arch/p7zip"
RDEPEND="${DEPEND}"

VALA_V=`equery list --format='$version' vala | tail -n 1`
SED_STRING="s/valac/valac-${VALA_V}/1"

src_prepare() {
	epatch "${FILESDIR}"/valac-0.18.patch || die
}
