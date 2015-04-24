# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_3 python3_4 )

inherit distutils-r1

DESCRIPTION="toolbelt of useful classes and functions to be used with python-requests"
HOMEPAGE="http://toolbelt.readthedocs.org/"
SRC_URI="https://github.com/sigmavirus24/requests-toolbelt/archive/0.3.0.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

DOCS=( AUTHORS.rst HISTORY.rst README.rst )
