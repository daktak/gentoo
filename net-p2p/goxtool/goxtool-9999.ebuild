# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="display Mt.Gox live market data (in the console) and experiment
with trading bots"
HOMEPAGE="https://bitcointalk.org/index.php?topic=148462"
SRC_URI=""
EGIT_REPO_URI="https://github.com/prof7bit/goxtool.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

DEPEND="dev-python/pycrypto"
RDEPEND="${DEPEND}"

src_install() {
		dodir /usr/share/${PN} || die
		exeinto /usr/share/${PN} || die
		doexe goxapi.py || die
		doexe strategy.py || die
		doexe websocket.py || die
		doexe ${PN}.py || die
		dosym /usr/share/${PN}/${PN}.py /usr/bin/${PN} || die
}

