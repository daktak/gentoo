# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd

SRC_URI="https://dev.azure.com/Readarr/Readarr/_apis/build/builds/1142/artifacts?artifactName=Packages&fileId=74CA7FD1583DB8797D6D3D3A299614D978DC18BECD7E555BFF50858F0E42F4AB02&fileName=Readarr.develop.${PV}.linux-core-x64.tar.gz&api-version=5.1 -> ${P}.tar.gz"

DESCRIPTION="Book Manager and Automation (Sonarr for Ebooks)"
HOMEPAGE="https://readarr.com/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist strip test"

RDEPEND="
	acct-group/readarr
	acct-user/readarr
	media-video/mediainfo
	dev-util/lttng-ust
	dev-db/sqlite
	media-libs/chromaprint[tools]"

MY_PN=readarr
S="${WORKDIR}/Readarr"

src_install() {
	newconfd "${FILESDIR}/${PN}.conf" ${PN}
	newinitd "${FILESDIR}/${PN}.init" ${PN}

	keepdir /var/lib/${PN}
	fowners -R ${PN}:${PN} /var/lib/${PN}

	insinto /etc/${PN}
	insopts -m0660 -o ${PN} -g ${PN}

	insinto /etc/logrotate.d
	insopts -m0644 -o root -g root
	newins "${FILESDIR}/${PN}.logrotate" ${PN}

	dodir  "/usr/share/${PN}"
	cp -R "${WORKDIR}/Readarr/." "${D}/usr/share/readarr" || die "Install failed!"

	systemd_dounit "${FILESDIR}/readarr.service"
	systemd_newunit "${FILESDIR}/readarr.service" "${PN}@.service"
}
