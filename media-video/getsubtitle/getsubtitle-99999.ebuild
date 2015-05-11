# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 autotools-utils autotools

BUILD_DIR=${S}

DESCRIPTION="Tool to download subtitles from shooter automatically."
HOMEPAGE="https://github.com/firnsan/GetSubtitle"
EGIT_REPO_URI="https://github.com/firnsan/GetSubtitle.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-misc/curl
		dev-libs/openssl:*[zlib]"
RDEPEND="${DEPEND}"
