# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games subversion autotools-utils

BUILD_DIR="${S}/gamewatch/tags/rel-${PV}"
DESCRIPTION="This is a generic engine for simulation of Game & Watch-like games"
HOMEPAGE="http://www.rangelreale.com/programming/game-watch-simulator"

ESVN_REPO_URI="https://${PN}.svn.sourceforge.net/svnroot/${PN}"
ESVN_PROJECT="rel-${PV}"
AUTOTOOLS_AUTORECONF=Y
ECONF_SOURCE=${BUILD_DIR}

PATCHES=( "${FILESDIR}/${P}.patch" )

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
#BUILD_DIR="${MY_S}"
DEPEND="media-libs/sdl-mixer \
	    media-libs/sdl-image \
		media-libs/sdl-gfx \
		sys-devel/boost-m4 \
		sys-devel/autoconf-archive \
		dev-perl/File-pushd"

RDEPEND="${DEPEND}"

INSOPTIONS="-ggames"

src_prepare() {
  cd ${ECONF_SOURCE}
  autotools-utils_src_prepare || die
}

src_install() {
  insinto /usr/share/${PN} || die
  doins -r ${ECONF_SRC}/data || die
  dobin ${ECONF_SRC}src/gameandwatch || die
}
