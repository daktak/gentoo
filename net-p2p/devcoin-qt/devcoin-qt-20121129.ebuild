# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DB_VER="4.8"

inherit versionator eutils qt4-r2 db-use

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
		sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]
        dev-qt/qtgui:4"
RDEPEND="${DEPEND}"

ECONF_SOURCE="${BUILD_DIR}"


src_configure() {
        OPTS=()

        #use dbus && OPTS+=("USE_DBUS=1")
        if use upnp; then
                OPTS+=("USE_UPNP=1")
        else
                OPTS+=("USE_UPNP=-")
        fi
        #use qrcode && OPTS+=("USE_QRCODE=1")
        #use 1stclassmsg && OPTS+=("FIRST_CLASS_MESSAGING=1")
        use ipv6 || OPTS+=("USE_IPV6=-")

        OPTS+=("BDB_INCLUDE_PATH=$(db_includedir "${DB_VER}")")
        OPTS+=("BDB_LIB_SUFFIX=-${DB_VER}")

        eqmake4 "${PN}.pro" "${OPTS[@]}"
}

src_compile() {
        # Workaround for bug #440034
        #share/genbuild.sh build/build.h

        emake
}

src_test() {
        cd src || die
        emake -f makefile.unix "${OPTS[@]}" test_bitcoin
        ./test_bitcoin || die 'Tests failed'
}

src_install() {
        qt4-r2_src_install
        dobin ${PN}
        insinto /usr/share/pixmaps
        newins "share/pixmaps/bitcoin.ico" "${PN}.ico"
        make_desktop_entry ${PN} "Bitcoin-Qt" "/usr/share/pixmaps/${PN}.ico" "Network;P2P"
}

