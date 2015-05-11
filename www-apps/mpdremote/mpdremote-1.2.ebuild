# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils webapp

S="${WORKDIR}"/${P}

DESCRIPTION="A PHP app to control an mpd-based jukebox from a mobile phone."
HOMEPAGE="http://iprog.com/projects"
SRC_URI="http://static.iprog.com/dl/${P}.tar.gz"

LICENSE=""
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-lang/php:*
		media-sound/mpd"
RDEPEND="${DEPEND}"

src_install() {
	webapp_src_preinst

	dodoc README
	rm -f COPYING README

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_src_install
}
