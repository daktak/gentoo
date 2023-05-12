# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9,10} )
inherit bash-completion-r1 optfeature python-single-r1

COMMIT="7ab3fd9a0ef4eb19d882cb3701d2025b4d41b63a"

DESCRIPTION="A simple but convenient CLI-based Matrix client app for sending and receiving"
HOMEPAGE="https://github.com/8go/matrix-commander"
SRC_URI="https://github.com/8go/matrix-commander/archive/refs/tags/v${PV}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		>=dev-python/aiofiles-0.6.0[${PYTHON_USEDEP}]
		>=dev-python/matrix-nio-0.14.1[${PYTHON_USEDEP}]
		dev-python/markdown[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/python-magic[${PYTHON_USEDEP}]
		dev-python/urllib3[${PYTHON_USEDEP}]
		dev-python/pyxdg[${PYTHON_USEDEP}]
	')
"

src_install() {
	python_newscript matrix_commander/matrix_commander.py "${PN}"
	newbashcomp auto-completion/bash/matrix-commander.bash "${PN}"
	einstalldocs
}

pkg_postinst() {
	optfeature "notification support" dev-python/notify2
}
