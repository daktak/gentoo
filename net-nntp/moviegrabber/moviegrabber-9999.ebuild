# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python2_7 )

inherit eutils git-r3 python-r1 user

DESCRIPTION="MovieGrabber is a fully automated way of downloading movie from
usenet"
HOMEPAGE="https://github.com/binhex/moviegrabber/"
EGIT_REPO_URI="https://github.com/binhex/moviegrabber.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND=""

DHOMEDIR="/var/${PN}"

pkg_setup() {
	# Control PYTHON_USE_WITH
	python_set_active_version 2
	python_pkg_setup

	# Create moviegrabber group
	enewgroup ${PN}
	# Create moviegrabber user, put in moviegrabber group
	enewuser ${PN} -1 -1 -1 ${PN}
}

src_install() {

	newconfd "${FILESDIR}/${PN}.conf" ${PN}
	newinitd "${FILESDIR}/${PN}.init" ${PN}
	keepdir /var/{${PN}/{configs,db},log/${PN}}
	fowners -R ${PN}:${PN} /var/{${PN}/{,configs,db},log/${PN}}

	# Default configuration file and directory

	insinto /var/${PN}/configs
	insopts -m0660 -o ${PN} -g ${PN}
	doins "${FILESDIR}/config.ini"

	# Rotation of log files
	insinto /etc/logrotate.d
	insopts -m0644 -o root -g root
	newins "${FILESDIR}/${PN}.logrotate" ${PN}

	# Add themes & code into /usr/share
	insinto /usr/share/${PN}
	doins -r certs interfaces lib MovieGrabber.py
	insinto /var/${PN}
	doins -r configs db images

	# ugly stuff can be found here. Someone should report upstream.
	dosym /var/${PN}/db /usr/share/${PN}/db
	dosym /var/${PN}/configs /usr/share/${PN}/configs
	dosym /var/${PN}/images /usr/share/${PN}/images
}

pkg_postinst() {
	python_mod_optimize /usr/share/${PN}

elog 	"MovieGrabber has been installed with data directories in /usr/share/${PN}"
	elog
	elog "New user/group ${PN}/${PN} has been created"
	elog
	elog "Config file is located in /var/${PN}/configs/config.ini"
	elog
	elog "Please configure /etc/conf.d/${PN} before starting as daemon!"
	elog
	elog "Start with ${ROOT}etc/init.d/${PN} start"
	elog "Visit http://<host ip>:9191 to configure MovieGrabber"
	elog "Default web username/password : ${PN}/secret"
	elog
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
