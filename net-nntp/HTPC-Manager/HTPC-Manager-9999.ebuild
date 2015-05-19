# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_6 python2_7 )

inherit python-r1 eutils user git-2

DESCRIPTION="Manage your HTPC from anywhere"
HOMEPAGE="http://htpc.io"
EGIT_REPO_URI="https://github.com/styxit/HTPC-Manager.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="${PYTHON_DEPS}
		virtual/jpeg:*
		media-libs/freetype
		sys-libs/zlib
		media-libs/libpng:*"
RDEPEND="${DEPEND}"

MY_PN="htpcmanager"

pkg_setup() {
	# Create HTPC-Manager group
	enewgroup ${MY_PN}
	# Create HTPC-Manager user, put in HTPC-Manager group
	enewuser ${MY_PN} -1 -1 -1 ${MY_PN}
}

src_install() {
	dodoc README.md
	newconfd "${FILESDIR}/${MY_PN}.conf" ${MY_PN}
	newinitd "${FILESDIR}/${MY_PN}.init" ${MY_PN}

	keepdir /var/${PN}
	fowners -R ${MY_PN}:${MY_PN} /var/${PN}
	keepdir /var/{${PN}/{cache,download},log/${PN}}
	fowners -R ${MY_PN}:${MY_PN} /var/{${PN}/{cache,download},log/${PN}}

	#Rotation of log files
	insinto /etc/logrotate.d
	insopts -m0644 -o root -g root
	newins "${FILESDIR}/${MY_PN}.logrotate" ${MY_PN}
	# wierd stuff ;-)
	last_commit=$(git rev-parse HEAD)
	echo ${last_commit} > version.txt
	insinto /usr/share/${PN}
	doins -r htpc interfaces libs modules Htpc.py version.txt || die
	fowners ${MY_PN}:${MY_PN} /usr/share/${PN}/version.txt
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
	elog "New user/group ${MY_PN}/${MY_PN} has been created"
	elog
	elog "Config file is located in /etc/${MY_PN}/${MY_PN}.ini"
	elog
	elog "Please configure /etc/conf.d/${MY_PN} before starting as daemon!"
	elog
	elog "Start with ${ROOT}etc/init.d/${MY_PN} start"
	elog "Visit http://<host ip>:8085 to configure HTPC-Manager"
	elog
}
