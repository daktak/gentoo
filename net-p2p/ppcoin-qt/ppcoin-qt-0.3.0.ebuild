# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
DB_VER="4.8"

MY_PN="ppcoin"

inherit versionator eutils db-use qt4-r2

S="${WORKDIR}/${MY_PN}-${PV}-linux/src"

DESCRIPTION="PPCoin is a crypto-currency project forked from Bitcoin and we aim
to achieve energy-efficiency and keep as much as possible the original Bitcoin's
preferable properties."
HOMEPAGE="http://www.ppcoin.org/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_PN}-${PV}-linux.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE="ipv6 upnp"

DEPEND=""
RDEPEND="${DEPEND}"

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

        eqmake4 "bitcoin-qt.pro" "${OPTS[@]}"
}


src_compile() {
    emake
}

src_install() {
        #qt4-r2_src_install
        dobin ${PN}
        insinto /usr/share/pixmaps
        newins "share/pixmaps/bitcoin.ico" "${PN}.ico"
        make_desktop_entry ${PN} "PPCoin-Qt" "/usr/share/pixmaps/${PN}.ico" "Network;P2P"
}

