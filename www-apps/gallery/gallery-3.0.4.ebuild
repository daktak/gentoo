# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

EAPI=4

inherit webapp eutils depend.php 

DESCRIPTION="Web based (PHP Script) photo album viewer/creator"
HOMEPAGE="http://gallery.menalto.com/"
SRC_URI="mirror://sourceforge/gallery/${PN}/${P}.zip"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE="+gd imagemagick mysql mysqli ffmpeg"

# Build depend is on unzip
DEPEND="app-arch/unzip"

RDEPEND="
	>=dev-db/mysql-5
	>=dev-lang/php-5.2.3[ctype,gd?,filter,iconv,json,mysql?,mysqli?,simplexml,tokenizer]
	>=www-servers/apache-2.2
	imagemagick? ( || ( media-gfx/imagemagick
			media-gfx/graphicsmagick[imagemagick] ) )
	ffmpeg? ( virtual/ffmpeg )
	"

REQUIRED_USE="|| ( gd imagemagick )
	|| ( mysql mysqli )"


My_PN="${PN}3"
S=${WORKDIR}/${My_PN}

need_httpd_cgi
need_php_httpd


src_install() {
	webapp_src_preinst

	INSTALL_DIR="/${My_PN}"

	cp -R * ${D}/${MY_HTDOCSDIR}
	cp .htaccess ${D}/${MY_HTDOCSDIR}

	keepdir ${MY_HTDOCSDIR}/var
	webapp_serverowned ${MY_HTDOCSDIR}/var
	webapp_configfile ${MY_HTDOCSDIR}/.htaccess

	ewarn "ATTANTION!"
	ewarn "gallery3 requires short_open_tag to be On"
	ewarn "You need to edit \"/etc/php/apache2-php5.?/php.ini\"" 
	ewarn "and change short_open_tag to \"On\" and "
	ewarn "re-start apache (/etc/init.d/apache2 restart)"

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}

