# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit systemd git-r3

DESCRIPTION="Synchronous audio player"
HOMEPAGE="https://github.com/badaix/snapcast"
EGIT_REPO_URI="https://github.com/badaix/snapcast.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="+client +server"

DEPEND="
	>=sys-devel/gcc-4.8
	media-libs/alsa-lib
	media-libs/tremor
	media-libs/libvorbis
	media-libs/flac
	media-sound/alsa-utils
	net-dns/avahi"

RDEPEND="${DEPEND}"

src_compile() {
	# Override the strip binary to : to prevent stripping debug symbols
	# Upstream makefile doesn't supply a better alternative.
	STRIP=":"

	for component in server client; do
		use "${component}" || continue
		emake STRIP="${STRIP}" "${component}"
	done
}

src_install() {
	for component in server client; do
		use "${component}" || continue

		emake DESTDIR="${D}" "install${component}"

		newinitd "${S}/${component}/debian/snap${component}.init" "snap${component}"
		systemd_dounit "${S}/${component}/debian/snap${component}.service"

		insinto "/etc/default"
		newins "${S}/${component}/debian/snap${component}.default" "snap${component}"
	done
}
