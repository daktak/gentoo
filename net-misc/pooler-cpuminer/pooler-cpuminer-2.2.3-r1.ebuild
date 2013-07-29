# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils

DESCRIPTION="Pooler's multi-threaded CPU miner for Litecoin and Bitcoin, fork of Jeff Garzik's reference cpuminer"
HOMEPAGE="https://github.com/pooler/cpuminer/"
SRC_URI="mirror://github/pooler/cpuminer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~*"
IUSE=""

DEPEND="net-misc/curl"
RDEPEND="${DEPEND}"

MY_P="cpuminer-${PV}"
S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}/${P}-fix-gnu-stack.patch"
}
