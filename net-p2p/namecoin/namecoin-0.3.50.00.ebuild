# Copyright 2010-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DB_VER="4.8"

inherit db-use eutils versionator

DESCRIPTION="A P2P network based domain name system"
HOMEPAGE="https://dot-bit.org/"
SRC_URI="https://github.com/namecoin/namecoin/tarball/nc0.3.50.00 -> ${P}.tgz"

LICENSE="MIT ISC"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="ssl upnp"

RDEPEND="
	>=dev-libs/boost-1.41.0[threads(+)]
	dev-libs/crypto++
	dev-libs/openssl[-bindist]
	upnp? (
		<net-libs/miniupnpc-1.6
	)
	sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]
"
DEPEND="${RDEPEND}
	>=app-shells/bash-4.1
"

S="${WORKDIR}/namecoin-namecoin-20dcc50"

pkg_setup() {
	local UG='namecoin'
	enewgroup "${UG}"
	enewuser "${UG}" -1 -1 /var/lib/namecoin "${UG}"
}

src_prepare() {
	cd src || die
	cp "${FILESDIR}/0.3.24-Makefile.gentoo" "Makefile" || die
}

src_compile() {
	local OPTS=()

	OPTS+=("CXXFLAGS=${CXXFLAGS}")
	OPTS+=( "LDFLAGS=${LDFLAGS}")

	OPTS+=("DB_CXXFLAGS=-I$(db_includedir "${DB_VER}")")
	OPTS+=("DB_LDFLAGS=-ldb_cxx-${DB_VER}")

	use ssl  && OPTS+=(USE_SSL=1)
	use upnp && OPTS+=(USE_UPNP=1)

	cd src || die
	emake "${OPTS[@]}" ${PN}d
}

src_install() {
	dobin src/${PN}d

	insinto /etc/namecoin
	newins "${FILESDIR}/namecoin.conf" namecoin.conf
	fowners namecoin:namecoin /etc/namecoin/namecoin.conf
	fperms 600 /etc/namecoin/namecoin.conf

	newconfd "${FILESDIR}/${PN}.confd" ${PN}d
	newinitd "${FILESDIR}/0.3.50-${PN}.initd" ${PN}d

	keepdir /var/lib/namecoin/.namecoin
	fperms 700 /var/lib/namecoin
	fowners namecoin:namecoin /var/lib/namecoin/
	fowners namecoin:namecoin /var/lib/namecoin/.namecoin
	dosym /etc/namecoin/namecoin.conf /var/lib/namecoin/.namecoin/namecoin.conf

	dodoc doc/README
	dodoc DESIGN-namecoin.md FAQ.md doc/README_merged-mining.md
}
