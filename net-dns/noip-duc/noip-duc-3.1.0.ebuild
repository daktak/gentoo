# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

MY_P=${P/duc-/duc_}
DESCRIPTION="Dynamic DNS Update Client for No-IP services"
HOMEPAGE="https://www.noip.com/download?page=linux"
SRC_URI="https://dmej8g5cpdyqd.cloudfront.net/downloads/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}/${MY_P}

src_compile() {
    cargo_src_compile
}
