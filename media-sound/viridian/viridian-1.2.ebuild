# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit python eutils

PYTHON_DEPEND="2:2.6"

MY_P=${P/viridian/Viridian}
DESCRIPTION="Viridian is an Ampache Client that displays all of your media from
your Ampache server in a simple and convenient way"
HOMEPAGE="http://viridian.daveeddy.com/"
SRC_URI="https://launchpad.net/viridianplayer/trunk/1.2-release/+download/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-plugins/gst-plugins-meta[http]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
    python_set_active_version 2
    python_pkg_setup
}

src_install() {
    "$(PYTHON)" setup.py install --root "${D}"|| die
}
