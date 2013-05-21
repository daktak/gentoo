# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
MY_P=${P/cde-/cde-src-}
MY_P=${MY_P/_/-}
S=${WORKDIR}/${PN}-2.2.0c
DESCRIPTION="The Common Desktop Environment, the classic UNIX desktop "
HOMEPAGE="http://sourceforge.net/projects/cdesktopenv/"
SRC_URI="mirror://sourceforge/cdesktopenv/${MY_P}.tar.gz"


LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="app-shells/ksh
		x11-libs/libXp
		x11-libs/libXt
		x11-libs/libXmu
		x11-libs/libXft
		x11-libs/motif
		x11-libs/libXaw
		x11-libs/libX11
		media-libs/freetype
		dev-lang/tcl
		sys-devel/m4
		app-arch/ncompress
		|| ( net-nds/rpcbind net-nds/portmap )
		sys-devel/bison
		x11-misc/xbitmaps
		"
RDEPEND="${DEPEND}"

src_prepare() {
	cd ${S}
	mkdir -p imports/x11/include  || die
	cd imports/x11/include   	  || die
	ln -s /usr/include/X11 . 	  || die
}

src_compile() {
	cd ${S}
	make World.dev || die "failed Compile"
	
}

src_install() {
	cd ${S}/admin/IntegTools/dbTools
	./installCDE -s ${S} || die
	cd ${S}/admin/IntegTools/post_install/linux
	./configRun -e || die
}
