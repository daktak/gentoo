# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2

DESCRIPTION="Automated solution to grab chinese subtitles from
http://www.shooter.cn"
HOMEPAGE="https://github.com/daktak/shooterSub"

EGIT_REPO_URI="https://github.com/daktak/shooterSub.git"

SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/configobj
		dev-python/guess-language
		dev-python/chardet
		dev-python/python-daemon"
RDEPEND="${DEPEND}"

src_install() {
	insinto /etc/${PN} || die
	doins shooterSub.ini || die
	doins nosubs.srt || die
	dobin shooterSub.py || die
	dobin getSub.py || die
}
