# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/prpltwtr/prpltwtr-0.12.0.ebuild,v 1.1 2012/07/10 08:49:31 jdhore Exp $

EAPI=5

inherit autotools autotools-utils git-2

DESCRIPTION="libpurple twitter protocol"
HOMEPAGE="https://code.google.com/p/prpltwtr/"
EGIT_REPO_URI="https://github.com/mikeage/${PN}.git"
EGIT_BRANCH="twitter-json"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${RDEPEND}
		virtual/pkgconfig"
RDEPEND=">=net-im/pidgin-2.6"

src_prepare() {
   eautoreconf
   cp src/prpltwtr/*.h src/gtkprpltwtr
}

src_install() {
        # wierd stuff ;-)
        last_commit=$(git rev-parse HEAD)
        echo ${last_commit} > version.txt
        dodoc version.txt
		autotools-utils_src_install
}

