# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DB_VER="4.8"

inherit db-use eutils

MY_PV="29-Nov-2012"

S=${WORKDIR}/${PN}

DESCRIPTION="Devcoin is an ethically inspired project based on the BitCoin
crypto-currency and created to help fund open source projects created by
programmers, hardware developers, writers, musicians, painters, graphic artists
and filmmakers."
HOMEPAGE="http://www.devtome.com/doku.php?id=devcoin"
SRC_URI="mirror://sourceforge/galacticmilieu/${PN}-${MY_PV}.tgz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE="upnp ipv6"

DEPEND=">=dev-libs/boost-1.41.0
	    dev-libs/openssl[-bindist]
		sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx] "
RDEPEND="${DEPEND}"

ECONF_SOURCE="${BUILD_DIR}"

src_prepare() {
	EPATCH ${FILESDIR}/{$PN}.patch
}

src_compile() {
	OPTS=()

	OPTS+=("DEBUGFLAGS=")
	OPTS+=("CXXFLAGS=${CXXFLAGS}")
	OPTS+=("LDFLAGS=${LDFLAGS}")

	OPTS+=("BDB_INCLUDE_PATH=$(db_includedir "${DB_VER}")")
	OPTS+=("BDB_LIB_SUFFIX=-${DB_VER}")

	if use upnp; then
		OPTS+=(USE_UPNP=1)
	else
		OPTS+=(USE_UPNP=)
	fi
	use ipv6 || OPTS+=("USE_IPV6=-")

	# Workaround for bug #440034
#	share/genbuild.sh src/obj/build.h

	cd src || die
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" -f makefile.unix "${OPTS[@]}"
}

src_install() {
	dobin src/${PN}
	dodoc doc/README
}

