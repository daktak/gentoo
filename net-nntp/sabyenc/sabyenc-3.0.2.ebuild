# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# Require python-2 with sqlite USE flag
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils

DESCRIPTION="Python yEnc package optimized for use within SABnzbd"
HOMEPAGE="https://sabnzbd.org/wiki/installation/sabyenc.html"
SRC_URI="https://github.com/sabnzbd/${PN}/archive/v${PV}.tar.gz"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

