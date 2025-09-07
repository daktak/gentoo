# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{11..13})
DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Python CFFI binding to libolm"
HOMEPAGE="https://gitlab.matrix.org/matrix-org/olm/"
SRC_URI="https://gitlab.matrix.org/matrix-org/olm/-/archive/${PV}/olm-${PV}.tar.bz2"
KEYWORDS="~amd64"
SLOT="0"
LICENSE="Apache-2.0"

S="${WORKDIR}/olm-${PV}/python"

BDEPEND=">=dev-libs/olm-${PV}"
RDEPEND="${BDEPEND}"
