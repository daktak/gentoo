# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="gpgdir is a perl script that uses the CPAN GnuPG::Interface module
to encrypt and decrypt directories using a gpg key specified in ~/.gpgdirrc."
HOMEPAGE="http://cipherdyne.org/gpgdir/"
SRC_URI="http://cipherdyne.org/gpgdir/download/${PN}-nodeps-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-perl/Class-MethodMaker
		dev-perl/TermReadKey
		dev-perl/GnuPG-Interface"
RDEPEND="${DEPEND}"

src_install() {
	doman ${PN}.1
	dobin ${PN}
}

src_test() {
	cd ${S}/test/
	for test in ${S}/test/*_test.pl; do
	 ${PERL} $test || die "Failed test "$test
    done
}
