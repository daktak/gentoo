# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/owncloud/owncloud-8.0.4.ebuild,v 1.1 2015/06/10 13:18:32 voyageur Exp $

EAPI=5

inherit eutils webapp

# Grab from http://repository.rainloop.net/v2/core.stable.json
TAG="edc31b7ce610007055627ea93757bea9"

DESCRIPTION="Simple, modern and fast web-based email client"
HOMEPAGE="http://www.rainloop.net"
SRC_URI="http://repository.rainloop.net/v2/webmail/${PV%.*}/${P}-${TAG}.zip"
LICENSE="AGPL-3"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/php[curl,iconv,json,ssl,xml]
	virtual/httpd-php"

S=${WORKDIR}

src_prepare() {
	epatch_user
}

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_serverowned -R "${MY_HTDOCSDIR}"/data

	webapp_src_install
}
