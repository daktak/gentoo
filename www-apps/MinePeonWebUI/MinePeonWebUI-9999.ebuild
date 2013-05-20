# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit webapp git-2

S="${WORKDIR}"/${P}

DESCRIPTION="${PN}"
HOMEPAGE="https://github.com/MineForeman/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/MineForeman/${PN}.git"

LICENSE="GPL-3"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="dev-php/pecl-rrd
		dev-lang/php"
RDEPEND="${DEPEND}"

src_install() {
        webapp_src_preinst

        epatch ${FILESDIR}/minepeon-9999.patch
        rm -f README.md

        insinto "${MY_HTDOCSDIR}"
        doins -r .

        webapp_src_install
}

pkg_postinst() {
	elog "Don't forget run "
	elog "webapp-config -I -h localhost -d MinePeonWebUI MinePeonWebUI 9999"
}
