# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Library to communicate with Deluge torrrent web server"
HOMEPAGE="https://github.com/matuck/DelugeApi"
SRC_URI="https://github.com/matuck/${PN}/archive/${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/php:*"
RDEPEND="${DEPEND}"

src_install() {
	insinto "/usr/share/php/${PN}"
	doins composer.json || die
	doins -r Client || die
	doins -r Exception || die
	doins -r Resources || die

	dodoc README.md
}
