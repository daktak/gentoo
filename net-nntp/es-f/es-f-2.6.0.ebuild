# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit versionator eutils webapp

MY_P=${PN}_$(replace_all_version_separators '.')
DESCRIPTION="|es|f| is a web based HTML frontend for esniper, a lightweight
console application for sniper"
HOMEPAGE="http://es-f.com/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-misc/esniper
	dev-lang/php:*
	virtual/httpd-php:*"
RDEPEND="${DEPEND}"

need_httpd_cgi

S=${WORKDIR}

src_configure() {
	#http://sourceforge.net/tracker/index.php?func=detail&aid=3482673&group_id=185222&atid=912405
	epatch "${FILESDIR}/${P}"-item.patch
}

src_compile() {
	:
}

src_install() {
	webapp_src_preinst

	#install Docs
	dodoc doc/BUGS doc/CONTRIBUTIONS doc/EXTENSIONS doc/INSTALL doc/NEWS \
	doc/SECURITY doc/TODO doc/UPGRADE doc/CHANGELOG doc/EVENTS \
	doc/FEATURES doc/LICENSE doc/RELEASENOTES doc/TEMPLATES \
	doc/TRANSLATIONS

	#install htdoc files
	insinto "${MY_HTDOCSDIR}"
	doins prepend.dist.php
	doins index.inc.php
	doins favicon.ico
	doins index.php
	doins robots.txt
	doins -r addon
	doins -r application
	doins -r button
	doins -r html
	doins -r js
	doins -r layout
	doins -r module
	doins -r plugin
	doins -r utilities
	doins -r setup
	doins web-install.php

	webapp_src_install
}
