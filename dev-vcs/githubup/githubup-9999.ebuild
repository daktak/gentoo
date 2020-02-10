# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="Automated solution to grab chinese subtitles from
http://www.shooter.cn"
HOMEPAGE="https://github.com/daktak/githubup"

EGIT_REPO_URI="https://github.com/daktak/githubup.git"

SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/configobj
		dev-python/simplejson
		dev-python/urllib3"
RDEPEND="${DEPEND}"

src_install() {
	insinto /etc/${PN} || die
	doins githubup.ini || die
	dobin githubup.py || die
}
