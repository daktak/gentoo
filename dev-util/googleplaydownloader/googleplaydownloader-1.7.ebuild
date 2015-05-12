# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python2_7 )

inherit python-r1 distutils-r1 eutils python-utils-r1

DESCRIPTION="Download APKs from the Google PlayStore"
HOMEPAGE="http://codingteam.net/project/googleplaydownloader"
SRC_URI="http://codingteam.net/project/googleplaydownloader/download/file/googleplaydownloader_1.7.orig.tar.gz"

LICENSE="AGPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE="build-android-checkin"

DEPEND="${PTYHON_DEPS}
		>=dev-libs/protobuf-2.4[python]
		build-android-checkin? ( >=dev-libs/protobuf-2.6[python]
							dev-java/maven-bin:*
							=dev-libs/protobuf-2.6.1-r3[java] )
		dev-python/requests
		dev-python/ndg-httpsclient
		dev-python/pyasn1
		dev-python/wxpython:*
		dev-python/configparser
		"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}.patch"
	if use build-android-checkin; then
		epatch "${FILESDIR}/protobuf-2.6.1.patch"
	fi
	default
}

src_compile() {
	if use build-android-checkin; then
		cd "${S}/${PN}/ext_libs/android-checkin"
		mvn clean package assembly:single
	fi
}

src_install() {
	 _distutils-r1_run_foreach_impl distutils-r1_python_install || die
	 _distutils-r1_run_foreach_impl distutils-r1_python_install_all || die
	python_moduleinto ${PN}/ext_libs/android-checkin/target
	python_foreach_impl python_domodule googleplaydownloader/ext_libs/android-checkin/target/android-checkin-1.1-jar-with-dependencies.jar || die
}
