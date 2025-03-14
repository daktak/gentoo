# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit flag-o-matic linux-info linux-mod multilib-minimal \
	portability toolchain-funcs unpacker udev

NV_URI="http://http.download.nvidia.com/XFree86/"
X86_NV_PACKAGE="NVIDIA-Linux-x86-${PV}"
AMD64_NV_PACKAGE="NVIDIA-Linux-x86_64-${PV}"
X86_FBSD_NV_PACKAGE="NVIDIA-FreeBSD-x86-${PV}"
AMD64_FBSD_NV_PACKAGE="NVIDIA-FreeBSD-x86_64-${PV}"

DESCRIPTION="NVIDIA Accelerated Graphics Driver"
HOMEPAGE="http://www.nvidia.com/ http://www.nvidia.com/Download/Find.aspx"
SRC_URI="
	amd64? ( ${NV_URI}Linux-x86_64/${PV}/${AMD64_NV_PACKAGE}.run )
	x86? ( ${NV_URI}Linux-x86/${PV}/${X86_NV_PACKAGE}.run )
	tools? ( ${NV_URI}nvidia-settings/nvidia-settings-${PV}.tar.bz2 )
"

LICENSE="GPL-2 NVIDIA-r2"
SLOT="0/${PV%.*}"
KEYWORDS="-* amd64 x86"
IUSE="acpi multilib kernel_FreeBSD kernel_linux pax_kernel static-libs +tools +X uvm"
RESTRICT="bindist mirror"
EMULTILIB_PKG="true"

COMMON="
	app-eselect/eselect-opencl
	kernel_linux? ( >=sys-libs/glibc-2.6.1 )
	tools? (
		dev-libs/atk
		dev-libs/glib:2
		dev-libs/jansson
		x11-libs/gdk-pixbuf
		>=x11-libs/gtk+-2.4:2
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/pango[X]
	)
	X? (
		>=app-eselect/eselect-opengl-1.0.9
	)
"
DEPEND="
	${COMMON}
	app-arch/xz-utils
	kernel_linux? ( virtual/linux-sources )
"
RDEPEND="
	${COMMON}
	acpi? ( sys-power/acpid )
	tools? ( !media-video/nvidia-settings )
	X? (
		>=x11-libs/libvdpau-0.3-r1
		sys-libs/zlib[${MULTILIB_USEDEP}]
		multilib? (
			>=x11-libs/libX11-1.6.2[${MULTILIB_USEDEP}]
			>=x11-libs/libXext-1.3.2[${MULTILIB_USEDEP}]
		)
	)
"

REQUIRED_USE="tools? ( X )"

QA_PREBUILT="opt/* usr/lib*"

S=${WORKDIR}/

nvidia_drivers_versions_check() {
	if use amd64 && has_multilib_profile && \
		[ "${DEFAULT_ABI}" != "amd64" ]; then
		eerror "This ebuild doesn't currently support changing your default ABI"
		die "Unexpected \${DEFAULT_ABI} = ${DEFAULT_ABI}"
	fi

	if use kernel_linux && kernel_is ge 4 10; then
		ewarn "Gentoo supports kernels which are supported by NVIDIA"
		ewarn "which are limited to the following kernels:"
		ewarn "<sys-kernel/gentoo-sources-4.10"
		ewarn "<sys-kernel/vanilla-sources-4.10"
		ewarn ""
		ewarn "You are free to utilize eapply_user to provide whatever"
		ewarn "support you feel is appropriate, but will not receive"
		ewarn "support as a result of those changes."
		ewarn ""
		ewarn "Do not file a bug report about this."
		ewarn ""
	fi

	# Kernel features/options to check for
	CONFIG_CHECK="~ZONE_DMA ~MTRR ~SYSVIPC ~!LOCKDEP"
	use x86 && CONFIG_CHECK+=" ~HIGHMEM"

	# Now do the above checks
	use kernel_linux && check_extra_config
}

pkg_pretend() {
	nvidia_drivers_versions_check
}

pkg_setup() {
	nvidia_drivers_versions_check

	# try to turn off distcc and ccache for people that have a problem with it
	export DISTCC_DISABLE=1
	export CCACHE_DISABLE=1

	if use kernel_linux; then
		MODULE_NAMES="nvidia(video:${S}/kernel)"
		use uvm && MODULE_NAMES+=" nvidia-uvm(video:${S}/kernel/uvm)"

		# This needs to run after MODULE_NAMES (so that the eclass checks
		# whether the kernel supports loadable modules) but before BUILD_PARAMS
		# is set (so that KV_DIR is populated).
		linux-mod_pkg_setup

		BUILD_PARAMS="IGNORE_CC_MISMATCH=yes V=1 SYSSRC=${KV_DIR} \
		SYSOUT=${KV_OUT_DIR} CC=$(tc-getBUILD_CC)"

		# linux-mod_src_compile calls set_arch_to_kernel, which
		# sets the ARCH to x86 but NVIDIA's wrapping Makefile
		# expects x86_64 or i386 and then converts it to x86
		# later on in the build process
		BUILD_FIXES="ARCH=$(uname -m | sed -e 's/i.86/i386/')"
	fi

	# set variables to where files are in the package structure
	if use kernel_FreeBSD; then
		NV_DOC="${S}/doc"
		NV_OBJ="${S}/obj"
		NV_SRC="${S}/src"
		NV_MAN="${S}/x11/man"
		NV_X11="${S}/obj"
		NV_SOVER=1
	elif use kernel_linux; then
		NV_DOC="${S}"
		NV_OBJ="${S}"
		NV_SRC="${S}/kernel"
		NV_MAN="${S}"
		NV_X11="${S}"
		NV_SOVER=${PV}
	else
		die "Could not determine proper NVIDIA package"
	fi
}

src_prepare() {
	# Please add a brief description for every added patch

	if use kernel_linux; then
		if kernel_is lt 2 6 9 ; then
			eerror "You must build this against 2.6.9 or higher kernels."
		fi

        eapply "${FILESDIR}"/0017-gcc-14.patch

		#if kernel_is ge 4 11 0 ; then
	#		eapply "${FILESDIR}"/nvidia-340.104-uvm-kernel-4.11.patch
		#fi
		#if kernel_is ge 5 6 0 ; then
		#	eapply "${FILESDIR}"/xf86-video-nvidia-legacy-0001-fix-5.6-rc1.patch 
		#fi
		if kernel_is ge 5 7 0 ; then
			eapply "${FILESDIR}"/0001-kernel-5.7.patch
		fi
		if kernel_is ge 5 8 0 ; then
			eapply "${FILESDIR}"/0002-kernel-5.8.patch
		fi
		if kernel_is ge 5 9 0 ; then
			eapply "${FILESDIR}"/0003-kernel-5.9.patch
		fi
		if kernel_is ge 5 10 0 ; then
			eapply "${FILESDIR}"/0004-kernel-5.10.patch
		fi
		if kernel_is ge 5 11 0 ; then
			eapply "${FILESDIR}"/0005-kernel-5.11.patch
		fi
        if kernel_is ge 5 14 0; then
			eapply "${FILESDIR}"/0006-kernel-5.14.patch
        fi
        if kernel_is ge 5 15 0; then
			eapply "${FILESDIR}"/0007-kernel-5.15.patch
        fi
        if kernel_is ge 5 16 0; then
			eapply "${FILESDIR}"/0008-kernel-5.16.patch
        fi
        if kernel_is ge 5 17 0; then
			eapply "${FILESDIR}"/0009-kernel-5.17.patch
        fi
        if kernel_is ge 5 18 0; then
			eapply "${FILESDIR}"/0010-kernel-5.18.patch
        fi
		if kernel_is ge 6 0 0; then
		    eapply "${FILESDIR}"/0011-kernel-6.0.patch
		fi
		if kernel_is ge 6 2 0; then
		    eapply "${FILESDIR}"/0012-kernel-6.2.patch
		fi 
		if kernel_is ge 6 3 0; then
		    eapply "${FILESDIR}"/0013-kernel-6.3.patch
		fi 
		if kernel_is ge 6 5 0; then
		    eapply "${FILESDIR}"/0014-kernel-6.5.patch
		fi 
		if kernel_is ge 6 6 0; then
		    eapply "${FILESDIR}"/0015-kernel-6.6.patch
		fi 
		if kernel_is ge 6 8 0; then
		    eapply "${FILESDIR}"/0016-kernel-6.8.patch
		fi

		# If greater than 2.6.5 use M= instead of SUBDIR=
#		convert_to_m "${NV_SRC}"/Makefile.kbuild
	fi

	if use pax_kernel; then
		ewarn "Using PAX patches is not supported. You will be asked to"
		ewarn "use a standard kernel should you have issues. Should you"
		ewarn "need support with these patches, contact the PaX team."
		eapply "${FILESDIR}"/${PN}-331.13-pax-usercopy.patch
		eapply "${FILESDIR}"/${PN}-337.12-pax-constify.patch
	fi

	local man_file
	for man_file in "${NV_MAN}"/*1.gz; do
		gunzip $man_file || die
	done

	# Allow user patches so they can support RC kernels and whatever else
	eapply_user
}

src_compile() {
	# This is already the default on Linux, as there's no toplevel Makefile, but
	# on FreeBSD there's one and triggers the kernel module build, as we install
	# it by itself, pass this.

	cd "${NV_SRC}"
	if use kernel_FreeBSD; then
		MAKE="$(get_bmake)" CFLAGS="-Wno-sign-compare" emake CC="$(tc-getCC)" \
			LD="$(tc-getLD)" LDFLAGS="$(raw-ldflags)" || die
	elif use kernel_linux; then
#		use uvm && MAKEOPTS=-j1
		linux-mod_src_compile
	fi

	if use tools; then
		emake -C "${S}"/nvidia-settings-${PV}/src/libXNVCtrl clean
		emake -C "${S}"/nvidia-settings-${PV}/src/libXNVCtrl \
			AR="$(tc-getAR)" \
			CC="$(tc-getCC)" \
			RANLIB="$(tc-getRANLIB)" \
			libXNVCtrl.a
		emake -C "${S}"/nvidia-settings-${PV}/src \
			AR="$(tc-getAR)" \
			CC="$(tc-getCC)" \
			LD="$(tc-getCC)" \
			LIBDIR="$(get_libdir)" \
			NVML_ENABLED=0 \
			NV_USE_BUNDLED_LIBJANSSON=0 \
			NV_VERBOSE=1 \
			RANLIB="$(tc-getRANLIB)" \
			STRIP_CMD=true
	fi
}

# Install nvidia library:
# the first parameter is the library to install
# the second parameter is the provided soversion
# the third parameter is the target directory if its not /usr/lib
donvidia() {
	# Full path to library minus SOVER
	MY_LIB="$1"

	# SOVER to use
	MY_SOVER="$2"

	# Where to install
	MY_DEST="$3"

	if [[ -z "${MY_DEST}" ]]; then
		MY_DEST="/usr/$(get_libdir)"
		action="dolib.so"
	else
		exeinto ${MY_DEST}
		action="doexe"
	fi

	# Get just the library name
	libname=$(basename $1)

	# Install the library with the correct SOVER
	${action} ${MY_LIB}.${MY_SOVER} || \
		die "failed to install ${libname}"

	# If SOVER wasn't 1, then we need to create a .1 symlink
	if [[ "${MY_SOVER}" != "1" ]]; then
		dosym ${libname}.${MY_SOVER} \
			${MY_DEST}/${libname}.1 || \
			die "failed to create ${libname} symlink"
	fi

	# Always create the symlink from the raw lib to the .1
	dosym ${libname}.1 \
		${MY_DEST}/${libname} || \
		die "failed to create ${libname} symlink"
}

src_install() {
	if use kernel_linux; then
		linux-mod_src_install

		# Add the aliases
		# This file is tweaked with the appropriate video group in
		# pkg_preinst, see bug #491414
		insinto /etc/modprobe.d
		newins "${FILESDIR}"/nvidia-169.07 nvidia.conf
		use uvm && doins "${FILESDIR}"/nvidia-uvm.conf

		# Ensures that our device nodes are created when not using X
		exeinto "$(get_udevdir)"
		newexe "${FILESDIR}"/nvidia-udev.sh-r1 nvidia-udev.sh
		udev_newrules "${FILESDIR}"/nvidia.udev-rule 99-nvidia.rules
	fi

	# NVIDIA kernel <-> userspace driver config lib
	donvidia "${NV_OBJ}"/libnvidia-cfg.so ${NV_SOVER}

	# NVIDIA framebuffer capture library
	donvidia "${NV_OBJ}"/libnvidia-fbc.so ${NV_SOVER}

	# NVIDIA video encode/decode <-> CUDA
	if use kernel_linux; then
		donvidia "${NV_OBJ}"/libnvcuvid.so ${NV_SOVER}
		donvidia "${NV_OBJ}"/libnvidia-encode.so ${NV_SOVER}
	fi

	if use X; then
		# Xorg DDX driver
		insinto /usr/$(get_libdir)/xorg/modules/drivers
		doins "${NV_X11}"/nvidia_drv.so

		# Xorg GLX driver
		donvidia "${NV_X11}"/libglx.so ${NV_SOVER} \
			/usr/$(get_libdir)/opengl/nvidia/extensions

		#abi override
		insinto /etc/X11/xorg.conf.d
		doins "${FILESDIR}"/20-opengl.conf
	fi

	# OpenCL ICD for NVIDIA
	if use kernel_linux; then
		insinto /etc/OpenCL/vendors
		doins "${NV_OBJ}"/nvidia.icd
	fi

	# Documentation
	if use kernel_FreeBSD; then
		dodoc "${NV_DOC}"/README
		use X && doman "${NV_MAN}"/nvidia-xconfig.1
		use tools && doman "${NV_MAN}"/nvidia-settings.1
	else
		# Docs
		newdoc "${NV_DOC}"/README.txt README
		dodoc "${NV_DOC}"/NVIDIA_Changelog
		doman "${NV_MAN}"/nvidia-smi.1
		use X && doman "${NV_MAN}"/nvidia-xconfig.1
		use tools && doman "${NV_MAN}"/nvidia-settings.1
		doman "${NV_MAN}"/nvidia-cuda-mps-control.1
	fi

	docinto html
	dodoc -r "${NV_DOC}"/html/*

	# Helper Apps
	exeinto /opt/bin/

	if use X; then
		doexe "${NV_OBJ}"/nvidia-xconfig
	fi

	if use kernel_linux ; then
		doexe "${NV_OBJ}"/nvidia-cuda-mps-control
		doexe "${NV_OBJ}"/nvidia-cuda-mps-server
		doexe "${NV_OBJ}"/nvidia-debugdump
		doexe "${NV_OBJ}"/nvidia-persistenced
		doexe "${NV_OBJ}"/nvidia-smi

		# install nvidia-modprobe setuid and symlink in /usr/bin (bug #505092)
		doexe "${NV_OBJ}"/nvidia-modprobe
		fowners root:video /opt/bin/nvidia-modprobe
		fperms 4710 /opt/bin/nvidia-modprobe
		dosym /{opt,usr}/bin/nvidia-modprobe

		doman nvidia-cuda-mps-control.1
		doman nvidia-modprobe.1
		doman nvidia-persistenced.1
		newinitd "${FILESDIR}/nvidia-smi.init" nvidia-smi
		newconfd "${FILESDIR}/nvidia-persistenced.conf" nvidia-persistenced
		newinitd "${FILESDIR}/nvidia-persistenced.init" nvidia-persistenced
	fi

	if use tools; then
		emake -C "${S}"/nvidia-settings-${PV}/src/ \
			DESTDIR="${D}" \
			LIBDIR="${D}/usr/$(get_libdir)" \
			PREFIX=/usr \
			NV_USE_BUNDLED_LIBJANSSON=0 \
			install

		if use static-libs; then
			dolib.a "${S}"/nvidia-settings-${PV}/src/libXNVCtrl/libXNVCtrl.a

			insinto /usr/include/NVCtrl
			doins "${S}"/nvidia-settings-${PV}/src/libXNVCtrl/*.h
		fi

		insinto /usr/share/nvidia/
		doins nvidia-application-profiles-${PV}-key-documentation

		insinto /etc/nvidia
		newins \
			nvidia-application-profiles-${PV}-rc nvidia-application-profiles-rc

		# There is no icon in the FreeBSD tarball.
		use kernel_FreeBSD || \
			doicon "${NV_OBJ}"/nvidia-settings.png

		domenu "${FILESDIR}"/nvidia-settings.desktop

		exeinto /etc/X11/xinit/xinitrc.d
		newexe "${FILESDIR}"/95-nvidia-settings-r1 95-nvidia-settings

	fi

	dobin "${NV_OBJ}"/nvidia-bug-report.sh

	#doenvd "${FILESDIR}"/50nvidia-prelink-blacklist

	if has_multilib_profile && use multilib ; then
		local OABI=${ABI}
		for ABI in $(get_install_abis) ; do
			src_install-libs
		done
		ABI=${OABI}
		unset OABI
	else
		src_install-libs
	fi

	is_final_abi || die "failed to iterate through all ABIs"

	readme.gentoo_create_doc
}

src_install-libs() {
	local inslibdir=$(get_libdir)
	local GL_ROOT="/usr/$(get_libdir)/opengl/nvidia/lib"
	local CL_ROOT="/usr/$(get_libdir)/OpenCL/vendors/nvidia"
	local nv_libdir="${NV_OBJ}"

	if use kernel_linux && has_multilib_profile && \
			[[ ${ABI} == "x86" ]] ; then
		nv_libdir="${NV_OBJ}"/32
	fi

	if use X; then
		# The GLX libraries
		donvidia "${nv_libdir}"/libEGL.so ${NV_SOVER} ${GL_ROOT}
		donvidia "${nv_libdir}"/libGL.so ${NV_SOVER} ${GL_ROOT}
		donvidia "${nv_libdir}"/libGLESv1_CM.so ${NV_SOVER} ${GL_ROOT}
		donvidia "${nv_libdir}"/libnvidia-eglcore.so ${NV_SOVER}
		donvidia "${nv_libdir}"/libnvidia-glcore.so ${NV_SOVER}
		donvidia "${nv_libdir}"/libnvidia-glsi.so ${NV_SOVER}
		donvidia "${nv_libdir}"/libnvidia-ifr.so ${NV_SOVER}
		if use kernel_FreeBSD; then
			donvidia "${nv_libdir}"/libnvidia-tls.so ${NV_SOVER}
		else
			donvidia "${nv_libdir}"/tls/libnvidia-tls.so ${NV_SOVER}
		fi

		# VDPAU
		donvidia "${nv_libdir}"/libvdpau_nvidia.so ${NV_SOVER}

		# GLES v2 libraries
		insinto ${GL_ROOT}
		doexe "${nv_libdir}"/libGLESv2.so.${PV}
		dosym libGLESv2.so.${PV} ${GL_ROOT}/libGLESv2.so.2
		dosym libGLESv2.so.2 ${GL_ROOT}/libGLESv2.so
	fi

	# NVIDIA monitoring library
	if use kernel_linux ; then
		donvidia "${nv_libdir}"/libnvidia-ml.so ${NV_SOVER}
	fi

	# CUDA & OpenCL
	if use kernel_linux; then
		donvidia "${nv_libdir}"/libcuda.so ${NV_SOVER}
		donvidia "${nv_libdir}"/libnvidia-compiler.so ${NV_SOVER}
		donvidia "${nv_libdir}"/libOpenCL.so 1.0.0 ${CL_ROOT}
		donvidia "${nv_libdir}"/libnvidia-opencl.so ${NV_SOVER}
	fi
}

pkg_preinst() {
	if use kernel_linux; then
		linux-mod_pkg_preinst

		local videogroup="$(getent group video | cut -d ':' -f 3)"
		if [ -z "${videogroup}" ]; then
			eerror "Failed to determine the video group gid"
			die "Failed to determine the video group gid"
		else
			sed -i \
				-e "s:PACKAGE:${PF}:g" \
				-e "s:VIDEOGID:${videogroup}:" \
				"${D}"/etc/modprobe.d/nvidia.conf || die
		fi
	fi

	# Clean the dynamic libGL stuff's home to ensure
	# we dont have stale libs floating around
	if [ -d "${ROOT}"/usr/lib/opengl/nvidia ] ; then
		rm -rf "${ROOT}"/usr/lib/opengl/nvidia/*
	fi
	# Make sure we nuke the old nvidia-glx's env.d file
	if [ -e "${ROOT}"/etc/env.d/09nvidia ] ; then
		rm -f "${ROOT}"/etc/env.d/09nvidia
	fi
}

pkg_postinst() {
	use kernel_linux && linux-mod_pkg_postinst

	# Switch to the nvidia implementation
	use X && "${ROOT}"/usr/bin/eselect opengl set --use-old nvidia
	"${ROOT}"/usr/bin/eselect opencl set --use-old nvidia

	readme.gentoo_print_elog

	if ! use X; then
		elog "You have elected to not install the X.org driver. Along with"
		elog "this the OpenGL libraries and VDPAU libraries were not"
		elog "installed. Additionally, once the driver is loaded your card"
		elog "and fan will run at max speed which may not be desirable."
		elog "Use the 'nvidia-smi' init script to have your card and fan"
		elog "speed scale appropriately."
		elog
	fi
	if ! use tools; then
		elog "USE=tools controls whether the nvidia-settings application"
		elog "is installed. If you would like to use it, enable that"
		elog "flag and re-emerge this ebuild. Optionally you can install"
		elog "media-video/nvidia-settings"
		elog
	fi
}

pkg_prerm() {
	use X && "${ROOT}"/usr/bin/eselect opengl set --use-old xorg-x11
}

pkg_postrm() {
	use kernel_linux && linux-mod_pkg_postrm
	use X && "${ROOT}"/usr/bin/eselect opengl set --use-old xorg-x11
}
