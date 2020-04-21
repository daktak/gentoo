# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=(python2_6 python2_7)

EGIT_REPO_URI="https://github.com/SickGear/SickGear.git"

inherit eutils user git-r3 python-r1

DESCRIPTION="Automatic TV-Series downloader for SABnzbd"
HOMEPAGE="https://github.com/SickGear/SickGear#readme"

LICENSE="GPL-2" # only
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-python/cheetah
"

pkg_setup() {
	# Create sickbeard group
	enewgroup ${PN}
	# Create sickbeard user, put in sickbeard group
	enewuser ${PN} -1 -1 -1 ${PN}
}

src_configure() {
  epatch "${FILESDIR}/fix_american_dad_sickgear.diff"
  epatch_user
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

	# wierd stuff ;-)
	last_commit=$(git rev-parse HEAD)
	echo ${last_commit} > version.txt

	insinto /usr/share/${PN}
	doins -r autoProcessTV gui lib sickbeard tests SickBeard.py sickgear.py tox.ini version.txt
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

	elog "SickBeard has been installed with data directories in /var/${PN}"
	elog
	elog "New user/group ${PN}/${PN} has been created"
	elog
	elog "Config file is located in /etc/${PN}/${PN}.ini"
	elog
	elog "Please configure /etc/conf.d/${PN} before starting as daemon!"
	elog
	elog "Start with ${ROOT}etc/init.d/${PN} start"
	elog "Visit http://<host ip>:8081 to configure SickBeard"
	elog "Default web username/password : sickbeard/secret"
	elog
}
