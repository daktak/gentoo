# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{4,5,6,7,8,9} )


inherit distutils-r1

DESCRIPTION="Holman SDK for Python on Linux "
HOMEPAGE="https://github.com/scottmckenzie/holman-linux-python/"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/scottmckenzie/holman-linux-python"
else
	MY_P="holman-linux-python-${PV}"
	SRC_URI="https://github.com/scottmckenzie/holman-linux-python/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"/${MY_P}
fi

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"

DEPEND=""
RDEPEND="${PYTHON_DEPS}
	dev-python/gatt-python
	"
