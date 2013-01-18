# vim: ft=sh
#!/usr/bin/env bash
BASE="3"
BRANCH="7"

case "$1" in
	arch)
		echo Preparing necessary files...
		cp distro/archlinux/PKGBUILD .
		cp distro/archlinux/linux"$BASE""$BRANCH"-pf.install .
		cp distro/archlinux/arch.config .config

		echo Building pf-kernel...
		makepkg -s
		;;
	arch-i686)
		echo Preparing necessary files...
		cp distro/archlinux/PKGBUILD .
		cp distro/archlinux/linux"$BASE""$BRANCH"-pf.install .
		cp distro/archlinux/arch-i686.config .config

		echo Building pf-kernel...
		linux32 makepkg -s
		;;
	ubuntu)
		echo Preparing necessary files...
		cp distro/ubuntu/ubuntu.config .config

		CPUS_COUNT=`cat /proc/cpuinfo | grep processor | wc -l`
		echo "Compiling using $CPUS_COUNT thread(s)"
		CONCURRENCY_LEVEL=$CPUS_COUNT LOCALVERSION="" make-kpkg --rootcmd fakeroot --initrd --revision 1 kernel_image kernel_headers
		;;
	ubuntu-i686)
		echo Preparing necessary files...
		cp distro/ubuntu/ubuntu-i686.config .config

		CPUS_COUNT=`cat /proc/cpuinfo | grep processor | wc -l`
		echo "Compiling using $CPUS_COUNT thread(s)"
		CONCURRENCY_LEVEL=$CPUS_COUNT LOCALVERSION="" make-kpkg --rootcmd fakeroot --initrd --revision 1 kernel_image kernel_headers
		;;
	debian)
		echo Preparing necessary files...
		cp distro/debian/debian.config .config

		CPUS_COUNT=`cat /proc/cpuinfo | grep processor | wc -l`
		echo "Compiling using $CPUS_COUNT thread(s)"
		CONCURRENCY_LEVEL=$CPUS_COUNT LOCALVERSION="" make-kpkg --rootcmd fakeroot --initrd --revision 1 kernel_image kernel_headers
		;;
	debian-i686)
		echo Preparing necessary files...
		cp distro/debian/debian-i686.config .config

		CPUS_COUNT=`cat /proc/cpuinfo | grep processor | wc -l`
		echo "Compiling using $CPUS_COUNT thread(s)"
		CONCURRENCY_LEVEL=$CPUS_COUNT LOCALVERSION="" make-kpkg --rootcmd fakeroot --initrd --revision 1 kernel_image kernel_headers
		;;
	*)
		echo Unsupported distro given. Please, try enother.
		;;
esac

echo Ready.
