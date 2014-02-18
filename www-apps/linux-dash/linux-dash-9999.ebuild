# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit webapp depend.php git-2 eutils

DESCRIPTION="web dashboard"
HOMEPAGE="http://github.com/afaqurk/linux-dash"
SRC_URI=""
EGIT_REPO_URI="https://github.com/afaqurk/${PN}.git"

LICENSE=""
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/php[json]"
RDEPEND="${DEPEND}"

src_install() {
webapp_src_preinst

rm -f README.md
rm -f LICENSE.md

insinto "${MY_HTDOCSDIR}"
doins -r .

webapp_src_install
}

pkg_postinst() {
elog "Don't forget run "
elog " webapp-config -I -h localhost -d ${PN} ${PN} ${PV}"
}
