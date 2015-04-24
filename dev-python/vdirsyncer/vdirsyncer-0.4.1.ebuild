# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_3 python3_4 )

inherit distutils-r1

DESCRIPTION="synchronization tool for vdir"
HOMEPAGE="https://github.com/untitaker/vdirsyncer"
SRC_URI="https://github.com/untitaker/vdirsyncer/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT-with-advertising"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/setuptools
>=dev-python/requests-toolbelt-0.3
>=dev-python/icalendar-3.6
>=dev-python/requests-2.6
>=dev-python/click-3.1
dev-python/lxml"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS.rst CHANGELOG.rst CONTRIBUTING.rst README.rst example.cfg )
