# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="SOAP webservices functional testing tool"
HOMEPAGE="https://www.soapui.org/downloads/open-source.html"
SRC_URI="http://cdn01.downloads.smartbear.com/soapui/${PV}/SoapUI-${PV}-linux-bin.tar.gz"
S="${WORKDIR}/SoapUI-${PV}"

LICENSE="EUPL-1.1"
SLOT="0"
KEYWORDS="amd64"

IUSE=""

RDEPEND=">=virtual/jre-1.7
  ${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.7
  app-arch/unzip
  ${COMMON_DEP}"

src_prepare() {
	# create starter script
	echo "#!/bin/sh" >"${T}/soapui"
	echo "cd /opt/${PN}/bin" >>"${T}/soapui"
	echo "exec ./soapui.sh" >>"${T}/soapui"

	# log to console only
	sed -i -e 's/ref="ERRORFILE"/ref="CONSOLE"/' -e 's/ref="FILE"/ref="CONSOLE"/' -e 's/ref="GLOBAL_GROOVY_LOG"/ref="CONSOLE"/' "bin/soapui-log4j.xml"
	rm bin/*.log
}
src_install() {
	local destdir="/opt/${PN}"
	exeinto "${destdir}/bin"
	doexe bin/soapui.sh
	insinto "${destdir}/"
	doins -r *
	fperms 755 "${destdir}/bin/soapui.sh"
	exeinto "/opt/bin"
	doexe "${T}/soapui"
}

