# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils autotools autotools-utils

DESCRIPTION="Filter based rss download"
HOMEPAGE="http://kylek.is-a-geek.org:31337/Automatic/"
SRC_URI="https://github.com/1100101/Automatic/archive/v${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
S="${WORKDIR}/Automatic-${PV}"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	./autogen.sh || die
}
