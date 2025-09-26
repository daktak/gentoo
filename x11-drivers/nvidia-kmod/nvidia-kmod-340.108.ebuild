# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit linux-mod-r1 readme.gentoo-r1 unpacker

MODULES_KERNEL_MAX=6.6
NV_URI="https://download.nvidia.com/XFree86/"

DESCRIPTION="NVIDIA Accelerated Graphic Driver - kernel module"
HOMEPAGE="https://www.nvidia.com/download/index.aspx"
SRC_URI="
	amd64? ( ${NV_URI}Linux-x86_64/${PV}/NVIDIA-Linux-x86_64-${PV}.run )
	x86? ( ${NV_URI}Linux-x86/${PV}/NVIDIA-Linux-x86-${PV}.run )
"

LICENSE="NVIDIA-r2"
SLOT="0/${PV%%.*}"
KEYWORDS="-* amd64 x86"

DEPEND="acct-group/video"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

# Patches taken from Ubuntu, Debian, AUR:
#   https://github.com/tseliot/nvidia-graphics-drivers/tree/340/debian/dkms_nvidia/patches
#   https://salsa.debian.org/nvidia-team/nvidia-graphics-drivers/-/tree/340xx/master/debian/module/debian/patches
#   https://aur.archlinux.org/packages/nvidia-340xx/
PATCHES=(
	"${FILESDIR}/use-kmem_cache_create_usercopy-on-4.16.patch"
	"${FILESDIR}/buildfix_kernel_5.7.patch"
	"${FILESDIR}/buildfix_kernel_5.7_fix_old.patch"
	"${FILESDIR}/buildfix_kernel_5.8.patch"
	"${FILESDIR}/buildfix_kernel_5.9.patch"
	"${FILESDIR}/buildfix_kernel_5.10.patch"
	"${FILESDIR}/buildfix_kernel_5.11.patch"
	"${FILESDIR}/buildfix_kernel_5.14.patch"
	"${FILESDIR}/buildfix_kernel_5.15.patch"
	"${FILESDIR}/buildfix_kernel_5.16.patch"
	"${FILESDIR}/buildfix_kernel_5.17.patch"
	"${FILESDIR}/buildfix_kernel_5.18.patch"
	"${FILESDIR}/buildfix_kernel_6.0.patch"
	"${FILESDIR}/buildfix_kernel_6.2.patch"
	"${FILESDIR}/buildfix_kernel_6.3.patch"
	"${FILESDIR}/buildfix_kernel_6.5.patch"
	"${FILESDIR}/buildfix_kernel_6.6.patch"
)

src_compile() {
	local modlist=( nvidia=video:kernel )
	local modargs=(
		IGNORE_CC_MISMATCH=yes NV_VERBOSE=1
		SYSOUT="${KV_OUT_DIR}" SYSSRC="${KV_DIR}"
	)
	use amd64 && modargs+=( ARCH=x86_64 )
	use x86 && modargs+=( ARCH=i386 )

	linux-mod-r1_src_compile
}

src_install() {
	local DOCS=()
	local DISABLE_AUTOFORMATTING="yes"
	local DOC_CONTENTS="\
Trusted users should be in the 'video' group to use NVIDIA devices.
You can add yourself by using: gpasswd -a my-user video

See '${EPREFIX}/etc/modprobe.d/nvidia.conf' for modules options."
	readme.gentoo_create_doc

	linux-mod-r1_src_install

	insinto /etc/modprobe.d
	newins "${FILESDIR}"/nvidia.modprobe nvidia.conf
}

pkg_preinst() {
	# set video group id based on live system (bug #491414)
	local g=$(getent group video | cut -d: -f3)
	[[ ${g} =~ ^[0-9]+$ ]] || die "Failed to determine video group id (got '${g}')"
	sed -i "s/@VIDEOGID@/${g}/" "${ED}"/etc/modprobe.d/nvidia.conf || die
}

pkg_postinst() {
	linux-mod-r1_pkg_postinst

	readme.gentoo_print_elog
}
