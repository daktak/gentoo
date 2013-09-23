# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit webapp depend.php git-2 eutils

DESCRIPTION="A PHP frontend for Bitcoind"
HOMEPAGE="http://github.com/BCEmporium/PHPCoin"
SRC_URI=""
EGIT_REPO_URI="https://github.com/BCEmporium/${PN}.git"

LICENSE=""
KEYWORDS="~amd64 ~x86"
IUSE="mysqli"

DEPEND="net-p2p/bitcoind
dev-lang/php"
RDEPEND="${DEPEND}"

src_install() {
webapp_src_preinst

epatch "${FILESDIR}/${PN}-20130719.patch" || die "Could not patch"
use mysqli && epatch "${FILESDIR}/${PN}-mysqli-20130923.patch" || die "Could not patch for mysqli"

rm -f README.md
rm -f TODO.md
rm -f configure.sh

insinto "${MY_HTDOCSDIR}"
doins -r .

webapp_src_install
}

pkg_postinst() {
elog "Create your database"
elog " mysql -u root -p"
elog "create schema ${PN};"
elog "quit;"
elog " mysql -u root -p ${PN} < /usr/share/webapps/${PN}/${PV}/htdocs/SQL/db.sql"
elog "And edit /usr/share/webapps/${PN}/${PV}/htdocs/sys/config.php"
elog "Don't forget run "
elog " webapp-config -I -h localhost -d ${PN} ${PN} ${PV}"
}
