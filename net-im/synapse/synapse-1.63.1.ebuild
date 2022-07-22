# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{7..10} )
#DISTUTILS_USE_SETUPTOOLS=pyproject.toml
DISTUTILS_USE_PEP517=poetry

inherit distutils-r1

DESCRIPTION="Synapse: Matrix reference homeserver"
HOMEPAGE="http://matrix.org"
LICENSE="GPL-3"

#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P/_rc/rc}.tar.gz"
SRC_URI="https://github.com/matrix-org/synapse/archive/v${PV/_rc/rc}.tar.gz -> ${P/_rc/rc}.tar.gz"
S="${WORKDIR}/synapse-${PV/_rc/rc}"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="systemd +hiredis"

RDEPEND="
	>=dev-python/jsonschema-2.5.1[${PYTHON_USEDEP}]
	>=dev-python/frozendict-1[${PYTHON_USEDEP}]
	>=dev-python/unpaddedbase64-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/canonicaljson-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/signedjson-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/matrix-common-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/ijson-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/pynacl-1.2.1[${PYTHON_USEDEP}]
	>=dev-python/service_identity-16.0.0[${PYTHON_USEDEP}]
	>=dev-python/jinja-2[${PYTHON_USEDEP}]
	>=dev-python/bleach-1.4.3[${PYTHON_USEDEP}]
	>=dev-python/psycopg-2.9.1[${PYTHON_USEDEP}]

	>=dev-python/twisted-18.9.0[${PYTHON_USEDEP}]
	systemd? ( dev-python/python-systemd[${PYTHON_USEDEP}] )

	>=dev-python/treq-15.1[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-16.0.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.11[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.1.9[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-modules-0.0.7[${PYTHON_USEDEP}]
	>=dev-python/daemonize-2.3.1[${PYTHON_USEDEP}]
	>=dev-python/bcrypt-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/pillow-3.1.2[jpeg,${PYTHON_USEDEP}]
	>=dev-python/sortedcontainers-1.4.4[${PYTHON_USEDEP}]
	>=dev-python/psutil-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/pymacaroons-0.13.0[${PYTHON_USEDEP}]
	>=dev-python/msgpack-0.5.0[${PYTHON_USEDEP}]
	>=dev-python/phonenumbers-8.2.0[${PYTHON_USEDEP}]
	>=dev-python/prometheus_client-0.3.0[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]

	>=dev-python/attrs-17.4.0[${PYTHON_USEDEP}]

	>=dev-python/netaddr-0.7.18[${PYTHON_USEDEP}]

	dev-db/redis
	hiredis? ( dev-python/hiredis[${PYTHON_USEDEP}] )
	dev-python/redis-py[${PYTHON_USEDEP}]
	dev-python/txredisapi[${PYTHON_USEDEP}]
	dev-python/importlib_metadata[${PYTHON_USEDEP}]

"
DEPEND="${RDEPEND}"

python_install_all() {
	distutils-r1_python_install_all
	newinitd "${FILESDIR}"/synapse.initd synapse
#	newconfd "${FILESDIR}"/synapse.confd synapse
}
