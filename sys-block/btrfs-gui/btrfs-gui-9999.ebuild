# Copyright 2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

PYTHON_DEPEND="3:3.1"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.*"
PYTHON_USE_WITH="tk"

inherit distutils

DESCRIPTION="Graphical user interface tool for inspecting and managing btrfs filesystems (local and remote)"
HOMEPAGE="http://carfax.org.uk/btrfs-gui"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="http://git.darksatanic.net/repo/btrfs-gui.git
		http://git.darksatanic.net/repo/btrfs-gui.git"
	inherit git-2
	SRC_URI=""
	#KEYWORDS=""
else
SRC_URI="http://carfax.org.uk/sites/default/files/${PN}-v${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="helper-only"

DEPEND=""
RDEPEND="sys-fs/btrfs-progs"

S="${WORKDIR}/${PN}-v${PV}"

if use helper-only; then
	DISTUTILS_SETUP_FILES="setup-helper.py"
fi

src_prepare() {
	distutils_src_prepare
	sed -e \
		"s:return PhotoImage(file=file):return PhotoImage(file='/usr/share/btrfs-gui/'+file):" \
		-i btrfsgui/gui/lib.py || die "sed failed"
}
