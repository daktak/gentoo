# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python2_5 python2_6 python2_7 )

inherit python-r1 distutils-r1 eutils

DESCRIPTION="Download APKs from the Google PlayStore"
HOMEPAGE="http://codingteam.net/project/googleplaydownloader"
SRC_URI="http://codingteam.net/project/googleplaydownloader/download/file/googleplaydownloader_1.7.orig.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-libs/protobuf-2.4[python]
		dev-python/requests
		dev-python/ndg-httpsclient
		dev-python/pyasn1
		dev-python/wxpython
		dev-python/configparser
		"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}.patch"
}
