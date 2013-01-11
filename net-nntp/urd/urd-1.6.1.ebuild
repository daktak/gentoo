# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils webapp

DESCRIPTION="URD is a web-based application for downloading usenet binaries."
HOMEPAGE="http://urdland.com/"
SRC_URI="http://urdland.com/${P}.tar.gz"

LICENSE="GPL-3"
#SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="arj p7zip ace zip +par2 +rar +cfv trickle +cksfv yencode subdownloader"

DEPEND=">=dev-lang/php-5.0i[gmp,cli,curl,pcntl,ssl,sockets,gd,xmlreader,xmlwriter]
		>=www-servers/apache-2.0
		trickle? ( net-misc/trickle )
		>=virtual/mysql-5.0
		net-news/yydecode
		rar? ( || ( app-arch/unrar app-arch/unrar-gpl app-arch/rar ) )
		dev-php/smarty
		par2? ( || ( app-arch/par app-arch/par2cmdline ) )
		arj? ( || ( app-arch/arj app-arch/unarj ) )
		p7zip? ( app-arch/p7zip )
		ace? ( app-arch/unace )
		zip? ( || ( app-arch/zip app-arch/unzip ) )
		cfv? ( app-arch/cfv )
		yencode? ( net-news/yencode )
		subdownloader? ( media-video/subdownloader )
		cksfv? ( app-arch/cksfv )"
RDEPEND="${DEPEND}"

src_configure() {
    :
}

src_compile() {
	:
}

src_install() {
        webapp_src_preinst
		# Install docs
		cd "${S}"
		dodoc docs/CHANGELOG docs/INSTALL docs/README docs/TODO \
			  docs/UPDATE docs/urdd_protocol docs/COPYING || die

		# Install htdoc files
		insinto  "${MY_HTDOCSDIR}" 
		doins -r functions || die
		doins -r mail_templates || die
		doins -r html || die
		doins -r examples || die
		doins -r install || die
		doins -r urdd
		doins index.php urdd.init urdd_syslog.conf \
			  make_x_lang.php urdd.sh || die
	    
		# Install server config file
		webapp_server_configfile apache urd.conf

		# Web Server needs to write and modify the following
		webapp_serverowned -R "${MY_HTDOCSDIR}"

		webapp_src_install
}

pkg_postinst() {
    elog "Open 'install.php' in your web browser and follow the install procedure"
	elog "Optionally: Run the install.sh from the console as root (eg \
	sudo ./install.php) to create a system user and group for urd"
}
