# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_3 python3_4 )

inherit distutils-r1

DESCRIPTION="Atomic file writes."
HOMEPAGE="https://pypi.python.org/pypi/atomicwrites/"
SRC_URI="mirror://pypi/a/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

DOCS=( README.rst )
