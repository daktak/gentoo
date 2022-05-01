# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

PYTHON_COMPAT=( python3_6 python3_7 python3_8 python3_9 python3_10 )

EGIT_REPO_URI="https://github.com/mylar3/mylar3.git"

inherit eutils user git-r3 python-r1

DESCRIPTION="Automatic comic book downloader for SABnzbd"
HOMEPAGE="https://github.com/mylar3/mylar3#readme"

LICENSE="GPL-2" # only
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
MYUSER="mylar"
MYGROUP="mylar"

RDEPEND="dev-python/APScheduler
		dev-python/cherrypy
		dev-python/cfscrape"

pkg_setup() {
	# Create mylar group
	enewgroup  ${MYGROUP}
	# Create mylar user, put in mylar group
	enewuser ${MYUSER} -1 -1 -1 ${MYGROUP}
}

#src_prepare() {
#	epatch "${FILESDIR}/post-process-py3.patch"
#}

src_install() {
	dodoc README.md

	newconfd "${FILESDIR}/${PN}.conf" ${PN}
	newinitd "${FILESDIR}/${PN}.init" ${PN}

	# Location of log and data files
	keepdir /var/${PN}
	fowners -R ${MYUSER}:${MYGROUP} /var/${PN}

	keepdir /var/{${PN}/{cache,download},log/${PN}}
	fowners -R ${MYUSER}:${MYGROUP} /var/{${PN}/{cache,download},log/${PN}}

	insinto /etc/${PN}
	insopts -m0660 -o ${MYUSER} -g ${MYGROUP}
	doins "${FILESDIR}/${PN}.ini"

	# Rotation of log files
	insinto /etc/logrotate.d
	insopts -m0644 -o root -g root
	newins "${FILESDIR}/${PN}.logrotate" ${PN}

	# wierd stuff ;-)
	last_commit=$(git rev-parse HEAD)
	echo ${last_commit} > version.txt

	insinto /usr/share/${PN}
	insopts -o ${MYUSER} -g ${MYGROUP}
	doins -r data mylar lib Mylar.py version.txt post-processing comictagger.py
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

	#python_mod_optimize /usr/share/${PN}

	elog "Headphones has been installed with data directories in /var/${PN}"
	elog
	elog "New user/group ${MYUSER}/${MYGROUP} has been created"
	elog
	elog "Config file is located in /etc/${PN}/${PN}.ini"
	elog
	elog "Please configure /etc/conf.d/${PN} before starting as daemon!"
	elog
	elog "Start with ${ROOT}etc/init.d/${PN} start"
	elog "Visit http://<host ip>:8181 to configure Mylar"
	elog "Default web username/password : mylar/secret"
	elog
}

