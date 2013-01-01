# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
MY_P=${P/${PV}/v${PV}}
S=${WORKDIR}/${MY_P}
DESCRIPTION="program to generate and execute
DesktopEntry files of the type Application"
HOMEPAGE="http:/e-jc.de/dex"
SRC_URI="http://e-jc.de/dex/downloads/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
  :
}

src_install() {
  doman dex.1 || die
  dobin dex   || die
}
