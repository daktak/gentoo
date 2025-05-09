# Copyright 2019-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DISTUTILS_USE_PEP517="setuptools"
DISTUTILS_USE_SETUPTOOLS=pyproject.toml

DESCRIPTION="Multilayered Matrix client library"
HOMEPAGE="https://pypi.python.org/pypi/matrix-nio https://github.com/poljar/matrix-nio"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+e2e"

DEPEND=""
BDEPEND="e2e? ( dev-python/python-olm )"
RDEPEND="${DEPEND}"
