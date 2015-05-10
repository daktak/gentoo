# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Dex is a tool to manage and launch autostart entries."

HOMEPAGE="http://e-jc.de/"
EGIT_REPO_URI="http://github.com/jceb/dex.git"
EGIT_COMMENT="${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/python-3.0.0
		dev-python/argparse"
RDEPEND="${DEPEND}"

inherit git-2 eutils

src_prepare() {
	epatch "${FILESDIR}/${P}-dedupe.patch" || die
}

src_install() {
	dobin dex || die
	dodoc README || die
	doman dex.1 || die
}
