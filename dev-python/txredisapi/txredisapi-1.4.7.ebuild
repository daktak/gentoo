# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )
inherit distutils-r1

DESCRIPTION="txredisapi is a non-blocking client driver for the redis database."
HOMEPAGE="https://github.com/IlyaSkriblovsky/txredisapi https://pypi.python.org/pypi/txredisapi"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/twisted[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
