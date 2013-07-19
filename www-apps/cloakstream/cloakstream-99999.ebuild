# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit webapp depend.php git-2 eutils

DESCRIPTION="Php web frontend for an existing Sick-Beard installation for video streaming"
HOMEPAGE="https://github.com/uberdiesel/cloakstream"
SRC_URI=""
EGIT_REPO_URI="https://github.com/uberdiesel/${PN}.git"

LICENSE=""
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="www-apache/mod_auth_token
		dev-lang/php[sqlite]
		www-servers/apache
		net-nntp/sickbeard"
RDEPEND="${DEPEND}"

src_install() {
	webapp_src_preinst

	rm -f README.md
	rm -f TODO.md
	rm -f configure.sh

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_src_install
}

pkg_postinst() {
	elog "Don't forget run "
	elog "webapp-config -I -h localhost -d ${PN} ${PN} ${PV}"
}
