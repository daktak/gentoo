# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games subversion autotools-utils
MY_S=${S}/gamewatch/tags/rel-${PV}
DESCRIPTION="This is a generic engine for simulation of Game & Watch-like games"
HOMEPAGE="http://www.rangelreale.com/programming/game-watch-simulator"

ESVN_REPO_URI="https://${PN}.svn.sourceforge.net/svnroot/${PN}"
ESVN_PROJECT="rel-${PV}"


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/sdl-mixer \
	    media-libs/sdl-image \
		media-libs/sdl-gfx \
		sys-devel/boost-m4 \
		sys-devel/autoconf-archive \
		dev-perl/File-pushd"

RDEPEND="${DEPEND}"

INSOPTIONS="-ggames"

src_configure() {
  cd ${MY_S}
  ./autogen.sh || die "failed autogen"
  if [[ -x ${ECONF_SOURCE:-.}/configure ]] ; then
	econf || die "failed configure"
  fi
  epatch "${FILESDIR}/${P}.patch" || die
}

src_compile() {
  cd ${MY_S}
  emake
}

src_install() {
  insinto /usr/share/${PN} || die
  doins -r ${MY_S}/data || die
  dobin ${MY_S}/src/gameandwatch || die
}
