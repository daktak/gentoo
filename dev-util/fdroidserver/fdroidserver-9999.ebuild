# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python2_5 python2_6 python2_7 )

inherit python-r1 eutils git-2 distutils-r1

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
	dev-python/paramiko"
RDEPEND="${DEPEND}"
