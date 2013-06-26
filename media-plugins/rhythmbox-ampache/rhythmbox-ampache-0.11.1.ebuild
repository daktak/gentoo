# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_DEPEND="2:2.6"

inherit eutils multilib python

DESCRIPTION="This is a plugin for Rhythmbox music player that allows it to
stream directly from an instance of an Ampache music streaming server."
HOMEPAGE="http://code.google.com/p/rhythmbox-ampache/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
    >=media-sound/rhythmbox-0.12.8[python]"


pkg_setup() {
    python_set_active_version 2
}

src_install() {
    insinto /usr/$(get_libdir)/rhythmbox/plugins
    doins -r ampache || die
}

pkg_postinst() {
    python_mod_optimize /usr/$(get_libdir)/rhythmbox/plugins/ampache
}

pkg_postrm() {
    python_mod_cleanup /usr/$(get_libdir)/rhythmbox/plugins/ampache
}

