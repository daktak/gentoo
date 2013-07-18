# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit subversion eutils autotools

PIDGIN=`equery list --format='$name-$version' pidgin`
#PIDGIN="pidgin-2.10.7"
DESCRIPTION="Pidgin plugin which takes advantage of the new XMPP interface to MSN"
HOMEPAGE="https://code.google.com/p/pidgin-msn-xmpp/"
ESVN_REPO_URI="http://pidgin-msn-xmpp.googlecode.com/svn/trunk"
ESVN_PROJECT="pidgin-msn-xmpp-read-only"

SRC_URI="mirror://sourceforge/pidgin/${PIDGIN}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-im/pidgin"
RDEPEND="${DEPEND}"

src_prepare() {
	unpack ${A} || die
	cp "${FILESDIR}/Makefile" . || die
}

src_compile() {
	emake || die
}

src_install() {
	insinto /usr/lib/pidgin
	doins libmsnxmpp.so || die
}
