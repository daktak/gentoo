# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit webapp depend.php git-2

DESCRIPTION="Ampache is a PHP-based tool for managing, updating and playing your audio files via a web interface."
HOMEPAGE="http://www.ampache.org/"
EGIT_REPO_URI="http://github.org/ampache/ampache.git"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="aac flac mp3 ogg transcode"

RDEPEND="dev-lang/php[gd,hash,iconv,mysql,session,unicode,xml,zlib]
        || ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )
        transcode? ( media-sound/lame
                aac? ( || ( media-libs/faad2 media-sound/alac_decoder ) )
                flac? ( media-libs/flac )
                mp3? ( media-sound/mp3splt )
                ogg? ( media-sound/mp3splt media-sound/vorbis-tools )
        )"
DEPEND=""

need_httpd_cgi

src_install() {
        webapp_src_preinst

        doman docs/man/*/*
        rm -rf docs/man/

        dodoc docs/*
        rm -rf docs/

        insinto "${MY_HTDOCSDIR}"
        doins -r .

        webapp_src_install
}

pkg_postinst() {
        elog "Install and upgrade instructions can be found here:"
        elog "  /usr/share/doc/${PF}/"
        webapp_pkg_postinst
}

