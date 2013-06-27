# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_5 python2_6 python2_7 )

inherit eutils multilib python-r1 subversion distutils-r1

MY_P="${PN}-read-only"
RB_PI="rhythmbox/plugins/ampache"

DESCRIPTION="Rhythmbox plugin to stream from Ampache"
HOMEPAGE="http://code.google.com/p/rhythmbox-ampache/"
ESVN_REPO_URI="http://${PN}.googlecode.com/svn/branches/for_rhythmbox-gtk+3"
ESVN_PROJECT="${PN}-read-only"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=media-sound/rhythmbox-2.95[python]"

S="${WORKDIR}/${MY_P}"
