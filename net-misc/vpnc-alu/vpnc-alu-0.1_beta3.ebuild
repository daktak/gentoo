# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vpnc/vpnc-0.5.3_p550.ebuild,v 1.2 2015/03/06 15:38:45 jlec Exp $

EAPI=5

inherit eutils linux-info systemd toolchain-funcs

DESCRIPTION="client for Alcatel-Lucent VPN routing software"
HOMEPAGE="http://acos.alcatel-lucent.com/projects/linux-ipsec/"
SRC_URI="https://acos.alcatel-lucent.com/frs/download.php/6819/${PN}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86"
IUSE="+gnutls"

DEPEND="
	dev-lang/perl
	dev-libs/libgcrypt:0=
	>=sys-apps/iproute2-2.6.19.20061214[-minimal]
	gnutls? ( net-libs/gnutls )
	!gnutls? ( dev-libs/openssl:0= )"
RDEPEND="${DEPEND}"

RESTRICT="!gnutls? ( bindist ) fetch"

CONFIG_CHECK="~TUN"

pkg_nofetch() {
    elog "Download the client file ${A} from
	https://acos.alcatel-lucent.com/frs/download.php/6819/${PN}.tar.gz"
    elog "and place it in ${DISTDIR:-/usr/portage/distfiles}."
}


src_install() {
	dobin usr/bin/vpnc usr/bin/vpnc-disconnect  || die
	doman usr/share/man/man8/vpnc.8.gz || die
	insinto /etc/vpnc 
	doins etc/vpnc/alu.conf || die
	exeinto /etc/vpnc
	doexe etc/vpnc/vpnc-script || die
}

