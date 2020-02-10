# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools eutils

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="http://repo.or.cz/siplcs"
	EGIT_BRANCH=mob
	inherit git-r3
else
	SRC_URI="mirror://sourceforge/sipe/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi


DESCRIPTION="Pidgin Plug-in SIPE (Sip Exchange Protocol)"
HOMEPAGE="http://sipe.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86",

IUSE="debug kerberos ocs2005-message-hack openssl telepathy voice"

RDEPEND=">=dev-libs/gmime-2.4.16
	dev-libs/libxml2
	openssl? ( dev-libs/openssl )
	!openssl? ( dev-libs/nss )
	kerberos? ( virtual/krb5 )
	voice? (
		>=dev-libs/glib-2.28.0
		>=net-libs/libnice-0.1.0
		media-libs/gstreamer:0.10
		>=net-im/pidgin-2.8.0
	)
	!voice? (
		>=dev-libs/glib-2.12.0:2
		net-im/pidgin
	)
	telepathy? (
		>=sys-apps/dbus-1.1.0
		>=dev-libs/dbus-glib-0.61
		>=dev-libs/glib-2.28:2
		>=net-libs/telepathy-glib-0.18.0
	)
"

DEPEND="dev-util/intltool
	virtual/pkgconfig
	${RDEPEND}
"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--enable-purple \
		--disable-quality-check \
		$(use_enable telepathy) \
		$(use_enable debug) \
		$(use_enable ocs2005-message-hack) \
		$(use_with kerberos krb5) \
		$(use_with voice vv) \
		$(use_enable !openssl nss) \
		$(use_enable openssl)
}

src_install() {
        # wierd stuff ;-)
        last_commit=$(git rev-parse HEAD)
        echo ${last_commit} > version.txt
        dodoc version.txt

	emake install DESTDIR="${D}"
	dodoc AUTHORS ChangeLog NEWS TODO README
}
