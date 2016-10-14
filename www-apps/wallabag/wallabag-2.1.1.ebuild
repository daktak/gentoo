# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit webapp versionator

DESCRIPTION="self hostable application for saving web pages"
HOMEPAGE="https://www.wallabag.org"

COMPOSER="composer.phar"

MY_PV=$(replace_version_separator 3 '-')
MY_PV="${MY_PV/alpha/alpha.}"
MY_PV="${MY_PV/beta/beta.}"
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

if [[ ${PV} = "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/wallabag/wallabag.git"
	SRC_URI=""
else
	SRC_URI="https://github.com/wallabag/wallabag/archive/${MY_PV}.tar.gz -> ${PF}.tar.gz"
fi

SRC_URI="${SRC_URI} https://getcomposer.org/composer.phar -> ${COMPOSER}"

LICENSE="GPL-2"

WEBAPP_MANUAL_SLOT="yes"
SLOT="2"

KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND=">=virtual/httpd-php-5.4
	net-libs/nodejs[npm]
	>=dev-lang/php-5.5[pdo,session,ctype,xml,hash,simplexml,json,gd,unicode,tidy,iconv,curl,nls,tokenizer,bcmath]
	|| ( dev-lang/php[mysql] dev-lang/php[postgres] dev-lang/php[sqlite] )"

DEPEND=">=dev-lang/php-5.5.9"

need_httpd_cgi

src_unpack() {
	if [[ -v _GIT_R3 ]]; then
		git-r3_src_unpack
	else
		unpack "${PF}.tar.gz"
	fi
	cp "${DISTDIR}/${COMPOSER}" "${T}/" || die
}

src_prepare() {
	SYMFONY_ENV=prod php -d memory_limit=-1 "${T}/${COMPOSER}" install --no-dev --optimize-autoloader --prefer-dist --no-interaction --verbose || die
	php bin/console wallabag:install --env=prod || die
	npm install || die
	grunt || die
	eapply_user
}

src_install() {
	webapp_src_preinst

	dodoc -r docs/*
	rm -r docs COPYING.md CREDITS.md README.md RELEASE_PROCESS.md || die

	cp -R * "${D}/${MY_HTDOCSDIR}" || die

	webapp_src_install
}

pkg_postinst() {
	elog "Install and upgrade instructions can be found here:"
	elog "http://doc.wallabag.org/en/v2/user/installation.html"
	elog "remove var/cache after using wabapp-config to install"

	webapp_pkg_postinst
}
