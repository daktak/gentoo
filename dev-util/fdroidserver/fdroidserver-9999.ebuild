# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit python-r1 eutils git-r3 distutils-r1

DESCRIPTION="Installable catalogue of FOSS applications for the Android platform"
HOMEPAGE="https://gitlab.com/fdroid/fdroidserver"
EGIT_REPO_URI="https://gitlab.com/fdroid/fdroidserver.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""
DEPEND="${PYTHON_DEPS}
	dev-python/pyasn1-modules
	dev-python/pyyaml
	dev-python/Babel
	dev-python/paramiko"
RDEPEND="${DEPEND}"

python_prepare_all() {
	cd "${S}"
	epatch "${FILESDIR}/locale.patch"
	distutils-r1_python_prepare_all
}
