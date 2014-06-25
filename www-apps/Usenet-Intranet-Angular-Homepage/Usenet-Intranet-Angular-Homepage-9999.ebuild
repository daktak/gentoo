# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit webapp depend.php git-2 eutils

DESCRIPTION="A simple little one-page Intranet homepage"
HOMEPAGE="https://github.com/daktak/Usenet-Intranet-Angular-Homepage"
SRC_URI=""
EGIT_REPO_URI="https://github.com/daktak/${PN}.git"

LICENSE=""
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
webapp_src_preinst

insinto "${MY_HTDOCSDIR}"
doins -r .

webapp_src_install
}

pkg_postinst() {
elog "Edit /usr/share/webapps/${PN}/${PV}/htdocs/intranet/serverconfig.php"
elog "Don't forget run "
elog " webapp-config -I -h localhost -d ${PN} ${PN} ${PV}"
}
