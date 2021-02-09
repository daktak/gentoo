# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_7 python3_8 python3_9 )
inherit distutils-r1

DESCRIPTION="Non-blocking client driver for the redis database"
HOMEPAGE="https://github.com/IlyaSkriblovsky/txredisapi https://pypi.python.org/pypi/txredisapi"
SRC_URI="https://github.com/IlyaSkriblovsky/txredisapi/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/simplejson"
RDEPEND="${DEPEND}"
