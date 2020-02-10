# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="libpurple (Pidgin, Finch) protocol plugin for Matrix.org."
HOMEPAGE="https://github.com/matrix-org/purple-matrix#readme"
EGIT_REPO_URI="https://github.com/matrix-org/purple-matrix.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORD="~amd64"
IUSE=""

DEPEND="net-im/pidgin
        dev-libs/glib:2
        dev-libs/json-glib
        net-libs/http-parser"
RDEPEND="${DEPEND}"

src_install() {
        echo $( git rev-parse HEAD ) > version.txt
        dodoc version.txt
        default
}
