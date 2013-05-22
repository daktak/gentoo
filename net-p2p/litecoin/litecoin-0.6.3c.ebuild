# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Litecoin - a lite version of Bitcoin optimized for CPU mining using scrypt as a proof of work scheme."
HOMEPAGE="https://github.com/litecoin-project/litecoin"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="ipv6 qrcode +upnp"
GITHUB_REPO="litecoin"
GITHUB_USER="litecoin-project"
GITHUB_TAG="v${PV}"

DEPEND="dev-libs/openssl[-bindist] \
=sys-libs/db-4.8*[cxx] \
dev-libs/boost \
upnp? ( net-libs/miniupnpc ) \
qrcode? ( media-gfx/libqrencode )"
RDEPEND="${DEPEND}"
SRC_URI="https://www.github.com/${GITHUB_USER}/${GITHUB_REPO}/tarball/${GITHUB_TAG} -> ${PN}-${GITHUB_TAG}.tar.gz"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/${GITHUB_USER}-${GITHUB_REPO}"-??????? "${S}" || die
}

src_compile() {
	cd ${S}/src
	export CXX="g++ -I /usr/include/db4.8"
	make ${MAKEOPTS} -f makefile.unix \
		USE_UPNP="$(use upnp && echo 1 || echo -)" \
		USE_IPV6="$(use ipv6 && echo 1 || echo 0)" \
		USE_QRCODE="$(use qrcode && echo 1 || echo 0)" \
	|| die
}

src_install() {
	dobin ${S}/src/litecoind
	cd ${S}/doc
	dodoc README README_ScryptMiner.txt Tor.txt assets-attribution.txt
}

