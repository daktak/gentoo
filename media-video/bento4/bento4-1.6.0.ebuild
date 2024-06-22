# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

BUILD="641-Omega"

DESCRIPTION="Bento4 is a C++ class library and tools designed to read and write ISO-MP4 files"
HOMEPAGE="https://github.com/xbmc/Bento4.git"
SRC_URI="https://github.com/xbmc/Bento4/archive/${PV}-${BUILD}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/Bento4-${PV}-${BUILD}"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release -DCMAKE_POSITION_INDEPENDENT_CODE=ON
	)
	cmake_src_configure
}
