# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PHP_EXT_NAME="libsodium"
DOCS="README.md"
USE_PHP="php8-1"

inherit php-ext-pecl-r3

KEYWORDS="amd64 x86"

DESCRIPTION="PHP bindings for dev-libs/libsodium"
LICENSE="BSD-2"
SLOT="0"
IUSE=""

DEPEND="dev-libs/libsodium"
RDEPEND="${DEPEND}"
