# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.5"
RESTRICT_PYTHON_ABIS="3.*"

inherit python distutils eutils git-2

DESCRIPTION="Installable catalogue of FOSS applications for the Android platform"
HOMEPAGE="https://gitlab.com/fdroid/fdroidserver"
EGIT_REPO_URI="https://gitlab.com/fdroid/fdroidserver.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""
DEPEND="dev-python/pyasn1-modules"
RDEPEND="${DEPEND}"

