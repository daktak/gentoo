# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit git-r3 eutils

DESCRIPTION="simple NNTP proxy with SSL support"
HOMEPAGE="https://github.com/nieluj/nntp-proxy"
EGIT_REPO_URI="https://github.com/nieluj/nntp-proxy.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/libconfig"
RDEPEND="${DEPEND}"

src_install() {
	# wierd stuff ;-)
	last_commit=$(git rev-parse HEAD)
	echo ${last_commit} > version.txt

	dodoc nntp-proxy.conf.example README.md
	insinto /etc/${PN}
	doins nntp-proxy.conf.example
	insinto /usr/share/${PN}
	doins version.txt
	dobin nntp-proxy
	newconfd "${FILESDIR}/${PN}.conf" "${PN}"
	newinitd "${FILESDIR}/${PN}.init" "${PN}"
}
