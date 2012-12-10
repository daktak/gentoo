# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils subversion

DESCRIPTION="Tool for splitting multiplexed Ogg files into separate streams"
HOMEPAGE="http://svn.xiph.org/trunk/ogg-tools/oggsplit/"
#SRC_URI="ftp://foo.bar.com/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-libs/libogg"
RDEPEND="${DEPEND}"

ESVN_REPO_URI="http://svn.xiph.org/trunk/ogg-tools/oggsplit/"
ESVN_BOOTSTRAP="autogen.sh"

src_install() {
	emake DESTDIR="$D" install || die "make install failed"
	dodoc AUTHORS README
}
