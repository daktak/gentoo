# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Home Automation System"
HOMEPAGE="https://www.domoticz.com"
SRC_URI="https://releases.domoticz.com/releases/release/domoticz_linux_x86_64.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd examples"

DEPEND="net-libs/libpsl
		net-libs/libcurl-gnutls
		net-libs/libssh2"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"
MY_PN="domoticz"

src_install() {
	if use systemd ; then
		systemd_newunit "${FILESDIR}/${MY_PN}.service" "${MY_PN}.service"
		systemd_install_serviced "${FILESDIR}/${MY_PN}.service.conf"
	else
		newinitd "${FILESDIR}/${MY_PN}.init.d" ${MY_PN}
		newconfd "${FILESDIR}/${MY_PN}.conf.d" ${MY_PN}
	fi

	insinto /var/lib/${MY_PN}
	#touch var/lib/${MY_PN}/.keep_db_folder

	dodoc History.txt License.txt

	insinto /opt/${MY_PN}
	doins -r Config www dzVents scripts
	doins server_cert.pem updatebeta updaterelease domoticz

	# cleanup examples and non functional scripts
	rm -rf opt/${MY_PN}/{updatedomo,server_cert.pem,History.txt,License.txt}
	rm -rf opt/${MY_PN}/scripts/{update_domoticz,restart_domoticz,download_update.sh,_domoticz_main*,logrotate}
	use examples || {
		rm -rf opt/${MY_PN}/scripts/{dzVents/examples,lua/*demo.lua,python/*demo.py,lua_parsers/example*,*example*}
		rm -rf opt/${MY_PN}/plugins/examples
	}
	#find opt/${MY_PN}/scripts -empty -type d -exec rmdir {} \;
}

pkg_postinst() {
	havescripts=$(find /opt/${PN} -maxdepth 1 -type d -name scripts)
	if [ ! -z "${havescripts}" ]; then
		mv /opt/${PN}/scripts/* /var/lib/${PN}/scripts/
		rmdir /opt/${PN}/scripts
	fi
	ln -s /var/lib/${PN}/scripts /opt/${PN}/scripts
}

pkg_prerm() {
	find /opt/${PN} -type l -exec rm {} \;
}

