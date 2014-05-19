# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit webapp depend.php git-2

DESCRIPTION="Fork of nnplus(2011) | NNTP / Usenet / Newsgroup indexer"
HOMEPAGE="https://github.com/nZEDb/nZEDb"
EGIT_REPO_URI="https://github.com/nZEDb/nZEDb.git"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/php-5.4[gd]
		dev-php/pear
		net-misc/curl
		>=virtual/mysql-5.5"
RDEPEND="${DEPEND}"

need_httpd_cgi

src_install() {
	webapp_src_preinst

	epatch "${FILESDIR}/${PN}-gentoo.patch" || die

	dodoc docs/*
	dodoc Changelog INSTALL.txt README.md
	rm INSTALL.txt README.md run.bat Changelog

	last_commit=$(git rev-parse HEAD)
	echo "${last_commit}" > version.txt

	insinto "${MY_HTDOCSDIR}"
	doins -r www/*

	insinto "${MY_HOSTROOTDIR}"/${PF}
	doins -r libs _install misc nzedb resources run test nZEDbBase.php autoloaders.php version.txt
	fperms +x "${MY_HOSTROOTDIR}"/${PF}/libs/smarty/templates_c

	webapp_serverowned -R "${MY_HOSTROOTDIR}"/${PF}/resources
	webapp_serverowned -R "${MY_HTDOCSDIR}"

	webapp_src_install
}

pkg_postinst() {
	elog "Install and upgrade instructions can be found here:"
	elog "  /usr/share/doc/${PF}/"
	webapp_pkg_postinst
}
