# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit python autotools eutils git-2

MY_PN="${PN/d/D}"

DESCRIPTION="An implementation of the MPRIS 2 interface as a client for MPD"
HOMEPAGE="http://github.com/eonpatapon/mpDris2"
SRC_URI="" # http://ayeon.org/projects/${MY_PN}/${MY_PN}-${PV}.tar.bz2"
EGIT_REPO_URI="git://github.com/eonpatapon/mpDris2.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

IUSE=""

DEPEND=">=dev-lang/python-2.4
		>=dev-python/dbus-python-0.80
		>=dev-python/pygobject-2.14
		>=dev-python/python-mpd-0.3.0"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_install() {
	emake install DESTDIR="${D}" || die "Failed to install"
}
