# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-r3

DESCRIPTION="Whatsapp plugin for libpurple (Pidgin)"
HOMEPAGE="http://davidgf.net/page/39/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

EGIT_REPO_URI="https://github.com/davidgfnet/whatsapp-purple.git"

DEPEND="net-im/pidgin
media-libs/freeimage"
RDEPEND="${DEPEND}"

src_install() {
        # wierd stuff ;-)
		last_commit=$(git rev-parse HEAD)
		echo ${last_commit} > version.txt
		dodoc version.txt
		default
}
