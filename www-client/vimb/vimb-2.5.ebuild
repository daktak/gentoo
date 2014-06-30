# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/vimprobable2/vimprobable2-1.4.2.ebuild,v 1.1 2014/01/23 00:52:34 radhermit Exp $

EAPI=5

inherit toolchain-funcs eutils

DESCRIPTION="Fast and lightweight vim like web browser"
HOMEPAGE="http://fanglingsu.github.io/vimb/"
SRC_URI="https://github.com/fanglingsu/vimb/archive/2.5.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-libs/libsoup:2.4
	net-libs/webkit-gtk:2
	x11-libs/gtk+:2
	x11-libs/libX11"
DEPEND="${RDEPEND}
	dev-lang/perl
	virtual/pkgconfig"

src_prepare() {
	tc-export CC
	epatch_user
}

src_install() {
	dobin ${PN}
	doman doc/${PN}.1 
}
