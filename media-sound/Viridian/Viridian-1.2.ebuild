# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_5 python2_6 python2_7 )

inherit python-r1 eutils distutils-r1

DESCRIPTION="Viridian is an Ampache Client that displays all of your Ampache
media in a simple and convenient way"
HOMEPAGE="http://viridian.daveeddy.com/"
SRC_URI="https://launchpad.net/viridianplayer/trunk/1.2-release/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="${PYTHON_DEPS}
	media-plugins/gst-plugins-meta:=[http]"
RDEPEND="${DEPEND}"
