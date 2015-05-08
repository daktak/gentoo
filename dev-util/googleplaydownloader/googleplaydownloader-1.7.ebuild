# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.5"
RESTRICT_PYTHON_ABIS="3.*"

inherit python distutils eutils

DESCRIPTION="Download APKs from the Google PlayStore"
HOMEPAGE="http://codingteam.net/project/googleplaydownloader"
SRC_URI="http://codingteam.net/project/googleplaydownloader/download/file/googleplaydownloader_1.7.orig.tar.gz"

LICENSE="GNU AGPL"
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
