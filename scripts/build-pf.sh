# vim: ft=sh
#!/usr/bin/env bash
BASE="3"
BRANCH="7"
RELEASE="1"

echo Updating pf-kernel source tree...
git fetch origin
#git checkout v"$BASE"."$BRANCH"."$RELEASE"-pf
git checkout pf-"$BASE"."$BRANCH"
git merge origin/pf-"$BASE"."$BRANCH"

case "$1" in
	arch)
		echo Preparing necessary files...
		cp distro/archlinux/PKGBUILD .
		cp distro/archlinux/kernel"$BASE""$BRANCH".install .
		cp distro/archlinux/arch.config .config

		echo Building pf-kernel...
		makepkg -s
		;;
	ubuntu)
		echo Preparing necessary files...
		cp distro/ubuntu/ubuntu.config .config

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
		CONCURRENCY_LEVEL=$CPUS_COUNT LOCALVERSION="" DEB_HOST_ARCH=i386 setarch i386 make-kpkg --rootcmd fakeroot --initrd --cross-compile - --arch i386 --revision 1 kernel_image kernel_headers
		;;
	*)
		echo Unsupported distro given. Please, try enother.
		;;
esac

echo Ready.
