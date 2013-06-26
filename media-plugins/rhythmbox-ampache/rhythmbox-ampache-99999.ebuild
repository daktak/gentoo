# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_DEPEND="2:2.6"

inherit eutils multilib python subversion

MY_P="${PN}-read-only"
RB_PI="rhythmbox/plugins/ampache"

DESCRIPTION="This is a plugin for Rhythmbox music player that allows it to
stream directly from an instance of an Ampache music streaming server."
HOMEPAGE="http://code.google.com/p/rhythmbox-ampache/"
ESVN_REPO_URI="http://${PN}.googlecode.com/svn/branches/for_rhythmbox-gtk+3"
ESVN_PROJECT="${PN}-read-only"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
    >=media-sound/rhythmbox-2.95[python]"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
    python_set_active_version 2
	python_pkg_setup
}

src_install() {
	"$(PYTHON)" setup.py install --root "${D}"|| die
    insinto /usr/$(get_libdir)/${RB_PI}
    doins -r * || die
}

pkg_postinst() {
    python_mod_optimize /usr/$(get_libdir)/${RB_PI}
}

pkg_postrm() {
    python_mod_cleanup /usr/$(get_libdir)/${RB_PI}
}

