# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_6 python2_7 )

EGIT_REPO_URI="https://github.com/SiCKRAGETV/SickRage.git"

inherit eutils user git-2 python-any-r1

DESCRIPTION="SickRage - Searches TheTVDB and TVRage for shows"
HOMEPAGE="http://www.sickrage.tv/"

LICENSE="GPL-3" # only
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${PTYHON_DEPS}"
RDEPEND="
	dev-python/cheetah
"

pkg_setup() {
	python-any-r1_pkg_setup

	# Create sickrage group
	enewgroup ${PN}
	# Create sickrage user, put in sickrage group
	enewuser ${PN} -1 -1 -1 ${PN}
}

src_install() {
	dodoc readme.md

	newconfd "${FILESDIR}/${PN}.conf" ${PN}
	newinitd "${FILESDIR}/${PN}.init" ${PN}

	# Location of log and data files
	keepdir /var/${PN}
	fowners -R ${PN}:${PN} /var/${PN}

	keepdir /var/{${PN}/{cache,download},log/${PN}}
	fowners -R ${PN}:${PN} /var/{${PN}/{cache,download},log/${PN}}

	insinto /etc/${PN}
	insopts -m0660 -o ${PN} -g ${PN}
	doins "${FILESDIR}/${PN}.ini"

	# Rotation of log files
	insinto /etc/logrotate.d
	insopts -m0644 -o root -g root
	newins "${FILESDIR}/${PN}.logrotate" ${PN}

	# weird stuff ;-)
	last_commit=$(git rev-parse HEAD)
	echo ${last_commit} > version.txt

	insinto /usr/share/${PN}
	doins -r autoProcessTV gui lib runscripts sickbeard tests tornado SickBeard.py googlecode_upload.py setup.py updater.py version.txt
}

pkg_postinst() {

	# we need to remove .git which old ebuild installed
	if [[ -d "/usr/share/${PN}/.git" ]] ; then
	   ewarn "stale files from previous ebuild detected"
	   ewarn "/usr/share/${PN}/.git removed."
	   ewarn "To ensure proper operation, you should unmerge package and remove directory /usr/share/${PN} and then emerge package again"
	   ewarn "Sorry for the inconvenience"
	   rm -Rf "/usr/share/${PN}/.git"
	fi

	elog "SickRage has been installed with data directories in /var/${PN}"
	elog
	elog "New user/group ${PN}/${PN} has been created"
	elog
	elog "Config file is located in /etc/${PN}/${PN}.ini"
	elog
	elog "Please configure /etc/conf.d/${PN} before starting as daemon!"
	elog
	elog "Start with ${ROOT}etc/init.d/${PN} start"
	elog "Visit http://<host ip>:8081 to configure SickRage"
	elog "Default web username/password : sickrage/secret"
	elog
}
