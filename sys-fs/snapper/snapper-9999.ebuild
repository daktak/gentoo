# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 autotools

DESCRIPTION="Command-line program for btrfs and ext4 snapshot management"
HOMEPAGE="http://snapper.io/"
EGIT_REPO_URI="http://github.com/openSUSE/snapper.git"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="sys-apps/dbus
	virtual/libintl
	dev-libs/libxml2
	dev-libs/boost
	sys-libs/zlib"
DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
	sys-devel/gettext
	virtual/pkgconfig"

src_configure() {
	# No configure file provided at the moment
	eautoreconf --force --install
	# No YaST in Gentoo
	econf --disable-zypp --with-conf="/etc/conf.d"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	nonfatal dodoc AUTHORS LIBVERSION VERSION package/snapper.changes
	# Exising configuration file required to function
	# Not certain if this is needed, now that Snapper is conf.d-aware
	mkdir -p "${D}/etc/conf.d"
	cp -n "${EGIT_SOURCEDIR}/data/sysconfig.snapper" "${D}/etc/conf.d/snapper" || die
}

pkg_postinst() {
	elog "In order to use Snapper, you need to set up at least one config"
	elog "manually, or else the tool will get confused. Typically you should"
	elog "create a '/.snapshots' directory, then copy the file"
	elog "'/etc/snapper/config-templates/default' into '/etc/snapper/configs/',"
	elog "rename the file to 'root', and add its name into '/etc/conf.d/snapper'."
	elog "That will instruct Snapper to snapshot the root of the filesystem by"
	elog "default. For more information, see the snapper(8) manual page."
}

