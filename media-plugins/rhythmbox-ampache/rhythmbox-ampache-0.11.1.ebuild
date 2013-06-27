# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_5 python2_6 python2_7 )

inherit eutils multilib python-r1

DESCRIPTION="Rhythmbox plugin to stream from Ampache"
HOMEPAGE="http://code.google.com/p/rhythmbox-ampache/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

