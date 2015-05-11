# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Open Source VirtualBox Client with Remote Management"
HOMEPAGE="http://remotebox.knobgoblin.org.uk/"
SRC_URI="http://remotebox.knobgoblin.org.uk/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-perl/SOAP-Lite
x11-misc/xdg-utils
net-misc/freerdp
dev-perl/libwww-perl
dev-lang/perl
dev-perl/gtk2-perl
>=x11-libs/gtk+-2.24:2
"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/lib.patch" || die
}

src_install() {
	dodoc docs/changelog.txt  docs/COPYING  docs/remotebox.pdf
	dobin remotebox || die
	insinto /usr
	doins -r share || die
	insinto /usr/share/applications
	doins packagers-readme/remotebox.desktop
}
