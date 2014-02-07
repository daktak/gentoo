# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 python

DESCRIPTION="NNTP binary poster with mulitple connection support"
HOMEPAGE="https://github.com/madcowfred/newsmangler"
EGIT_REPO_URI="https://github.com/madcowfred/newsmangler.git"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	insinto "$(python_get_sitedir)/${PN}" 
	doins ${PN}/* || die
	dobin mangler.py || die
	dodoc docs/CHANGELOG docs/TODO docs/sample.conf || die	
}

