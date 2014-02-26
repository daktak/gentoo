# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit vala 

DESCRIPTION="Chameleon theme for Gnome Shell"
HOMEPAGE="https://github.com/satya164/elegance-colors"
SRC_URI="https://github.com/satya164/elegance-colors/archive/v2.8.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
    x11-libs/gtk+:3
    gnome-base/gnome-shell"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's/CC=valac/CC=valac-0.22/' Makefile || die "Sed failed!"
}

