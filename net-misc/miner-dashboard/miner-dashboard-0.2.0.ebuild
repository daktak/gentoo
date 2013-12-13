# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Node.js based app to show the current status of your miner in a browser"
HOMEPAGE="https://github.com/selaux/miner-dashboard"
SRC_URI="https://github.com/selaux/${PN}/archive/${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-lib/nodejs"
RDEPEND="${DEPEND}"

src_install() {
	insinto /var/lib/${PN}
	doins -r config frontend lib templates test || die
	doins  .travis.yml Gruntfile.js app.js jshint.client.json jshint.client.json package.json || die
	dodoc README.md || die
}
