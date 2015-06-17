# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/prpltwtr/prpltwtr-0.12.0.ebuild,v 1.1 2012/07/10 08:49:31 jdhore Exp $

EAPI=5

inherit autotools autotools-utils

DESCRIPTION="Pidgin plugin to automatically expand shortlinks "
HOMEPAGE="https://github.com/mikeage/expand"
SRC_URI="https://github.com/mikeage/${PN}/archive/${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${RDEPEND}
		virtual/pkgconfig"
RDEPEND=">=net-im/pidgin-2.6"

src_prepare() {
   eautoreconf
}
