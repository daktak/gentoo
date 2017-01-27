# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="KeePassXC - KeePass Cross-platform Community Edition"
HOMEPAGE="ihttps://github.com/keepassxreboot/keepassxc"
EGIT_REPO_URI=(
	"https://github.com/keepassxreboot/${PN}"
)

LICENSE="LGPL-2.1 GPL-2 GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="debug test"

RDEPEND="dev-libs/libgcrypt:=
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	net-libs/libmicrohttpd
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5
	dev-qt/qtconcurrent:5
	test? ( dev-qt/qttest:5 )
"

src_prepare() {
	 use test || \
		sed -e "/^find_package(Qt5Test/d" -i CMakeLists.txt || die

	 cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_TESTS="$(usex test)"
		-DWITH_GUI_TESTS=OFF
	)
	cmake-utils_src_configure
}

pkg_postinst() {
	elog "Optional dependencies for auto-type on X11:"
	elog "  x11-libs/libXi"
	elog "  x11-libs/libXtst"
	elog "  dev-qt/qtx11extras:5"
}
