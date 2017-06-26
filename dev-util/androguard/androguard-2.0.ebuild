# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-r1 distutils-r1 eutils python-utils-r1

DESCRIPTION="Reverse engineering, Malware and goodware analysis of Android applications ... and more (ninja !) "
HOMEPAGE="https://github.com/androguard/androguard"
SRC_URI="https://github.com/androguard/${PN}/archive/v${PV}.tar.gz"

LICENSE="CL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/libffi
		dev-python/clint"
RDEPEND="${DEPEND}"
