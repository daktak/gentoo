# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="libpurple (Pidgin, Finch) protocol plugin for LINE."
HOMEPAGE="http://altrepo.eu/git/purple-line"
EGIT_REPO_URI="http://altrepo.eu/git/purple-line.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-im/pidgin
	dev-util/thrift"
RDEPEND="${DEPEND}"

src_install() {
	# wierd stuff ;-)
	last_commit=$(git rev-parse HEAD)
	echo ${last_commit} > version.txt
	dodoc version.txt
	default
}
