# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games git-2

DESCRIPTION="Tobias Funke cowsay"
HOMEPAGE="https://github.com/daktak/tobias-say"
EGIT_REPO_URI="https://github.com/daktak/tobias-say.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="games-misc/cowsay
		games-misc/fortune-mod"
RDEPEND="${DEPEND}"


src_install () {
	COWV=`equery list --format='$name-$version' cowsay`
	insinto /usr/share/fortune
	doins tobias
	doins tobias.dat || die
	insinto /usr/share/${COWV}/cows
	doins tobias.cow || die
	dobin tobias.sh || die
}
