#!/usr/bin/env bash
#
# Script to create Mageia official base images for integration with stackbrew
# library.
#
# Needs to be run from Mageia 6 or greater, as it requires DNF.
#
# Tested working versions are for Mageia 6 onwards (inc. cauldron).
#
#

set -e

mkimg="$(basename "$0")"
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
container=$(buildah from scratch)
echo $container
buildah config --label maintainer="Joseph C Wang <joequant@gmail.com>" $container
mountpoint=$(buildah mount $container)
rootfsDir=$mountpoint

usage() {
	echo >&2 "usage: $mkimg --version=mageia_version [--mirror=url] [--package-manager=(dnf|microdnf|urpmi)] [--forcearch=ARCH] [--with-systemd] [--quiet]"
	echo >&2 "   ie: $mkimg --version=6 --with-systemd"
	echo >&2 "       $mkimg --version=cauldron --package-manager=dnf --with-systemd"
	echo >&2 "       $mkimg --version=6 --mirror=http://mirrors.kernel.org/mageia/distrib/6/x86_64/ --with-systemd"
	echo >&2 "       $mkimg --version=6 --mirror=http://mirrors.kernel.org/mageia/distrib/6/armv7hl/ --forcearch=armv7hl"
	echo >&2 "       $mkimg --version=6 --package-manager=microdnf"
	exit 1
}

if [ -e "$script_dir/proxy.sh" ]; then
        . $script_dir/proxy.sh
fi

optTemp=$(getopt --options 'v:,p:,a:,s,q,h,n:' --longoptions 'version:,mirror:,package-manager:,forcearch:,with-systemd,quiet,help,name:' --name $mkimg -- "$@")
eval set -- "$optTemp"
unset optTemp

releasever=
mirror=
buildarch=
while true; do
        case "$1" in
                -v|--version) releasever="$2" ; shift 2 ;;
                -m|--mirror) mirror="$2" ; shift 2 ;;
                -p|--package-manager) pkgmgr="$2" ; shift 2 ;;
                -a|--forcearch) buildarch="$2" ; shift 2 ;;
                -s|--with-systemd) systemd=true ; shift ;;
                -q|--quiet) quiet=true ; shift ;;
                -h|--help) usage ;;
                -n|--name) name="$2" ; shift 2 ;;
                 --) shift ; break ;;
        esac
done

export LC_ALL=C
export LANGUAGE=C
export LANG=C

if [ ! -x /usr/bin/dnf ]; then
	echo "Error: DNF is not installed!"
	echo "Please install DNF before continuing!"
	exit 1
fi

if [ ! -z "$buildarch" -a -z "$mirror" ]; then
	echo "Error: Mirror must be specified when setting a specific architecture!"
	exit 1
fi

if [ -z $name ]; then
        name="joequant/cauldron"
fi

if [ -z $buildarch ]; then
	# Attempt to identify target arch
	buildarch="$(rpm --eval '%{_target_cpu}')"
fi

if [ ! -z $buildarch ]; then
	# Determine if the arch is not native...
	rpmbuildarch="$(rpm --eval '%{_target_cpu}')"
	if [ "$rpmbuildarch" != "$buildarch" ]; then
		# Check for the existance of qemu-user-static
		if ! rpm --quiet --query qemu-user-static; then
			echo "Error: 'qemu-user-static' needs to be installed for non-native rootfs builds!"
			exit 1
		fi
		# To ensure qemu-user-static can be used, restart systemd-binfmt
		systemctl restart systemd-binfmt.service
	fi
fi

if [ -z $releasever ]; then
    releasever="cauldron"
        # Attempt to match host version
        #if [ -r /etc/mageia-release ]; then
        #        releasever="$(sed 's/^[^0-9\]*\([0-9.]\+\).*$/\1/' /etc/mageia-release)"
        #else
        #        echo "Error: no version supplied and unable to detect host mageia version"
        #        exit 1
        #fi
fi

if [ ! -z $mirror ]; then
        # If mirror provided, use it exclusively
	# Unfortunately, when using a mirror with --repofrompath,
	# we don't have a nice way to bootstrap with gpg keys,
	# so installations fail unless we pass --nogpgcheck
	# See: https://bugzilla.redhat.com/show_bug.cgi?id=1689591
        reposetup="--nogpgcheck --disablerepo=* --repofrompath=mgarel,$mirror/media/core/release/ --repofrompath=mgaup,$mirror/media/core/updates/ --enablerepo=mgarel --enablerepo=mgaup"
fi

if [ $releasever == "cauldron" ]; then
    repo=cauldron-$buildarch
else
    repo=mageia-$buildarch
fi

if [ -z $mirror ]; then
	# Ensure we are on a Mageia system when not specifying a mirror
	if [ ! -e /etc/mageia-release ]; then
		echo "Error: No mirror specified but not on a Mageia system!"
		exit 1
	fi
        # If mirror is *not* provided, use mirrorlist
        reposetup="--nogpgcheck --disablerepo=* --enablerepo=$repo"
fi

if [ ! -z $pkgmgr ]; then
        valid_pkg_mgrs="dnf microdnf urpmi"

        [[ $valid_pkg_mgrs =~ (^|[[:space:]])$pkgmgr($|[[:space:]]) ]] || (echo "Invalid package manager selected." && exit 1)

        echo -e "--------------------------------------"
        echo -e "Creating image to use $pkgmgr."
        echo -e "--------------------------------------\n"

fi

# Must be after the non-empty check or otherwise this will fail
if [ -z $pkgmgr ]; then
        pkgmgr="dnf"
fi

extrapkgs=""
# If urpmi is included, we *must* add curl to the target environment,
# since aria2 segfaults on some architectures, like aarch64
if [[ $pkgmgr == *"urpmi"* ]]; then
        extrapkgs="$extrapkgs curl"
fi

if [ ! -z $systemd ]; then
        echo -e "--------------------------------------"
        echo -e "Creating image with systemd support."
        echo -e "--------------------------------------\n"
        extrapkgs="$extrapkgs systemd"
fi

(
    dnf \
            --forcearch="$buildarch" \
            --installroot="$rootfsDir" \
            --releasever="$releasever" \
            --setopt=install_weak_deps=False \
            --nodocs --assumeyes ${quiet:\--quiet} \
            download makedev filesystem
)

rpm --initdb  --root $rootfsDir
rpm -Uvh --nodeps filesystem-*.rpm  --root $rootfsDir
rpm -Uvh --noscripts --nodeps makedev-*.rpm  --root $rootfsDir
rm -f filesystem-*.rpm  makedev-*.rpm

(

        dnf \
            --nogpgcheck \
            --forcearch="$buildarch" \
            --installroot="$rootfsDir" \
            --releasever="$releasever" \
            --setopt=install_weak_deps=False \
            --nodocs --assumeyes install \
            basesystem-minimal-core locales locales-en \
	    ncurses sudo dnf
: '
	cp $script_dir/mirrorlist $rootfsDir/etc/yum.repos.d
	cat <<EOF > $rootfsDir/etc/yum.repos.d/mirrors.repo
[mirrors]
name=mirrors
mirrorlist=file:///etc/yum.repos.d/mirrorlist
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Mageia
enabled=1
EOF
    rm $rootfsDir/etc/yum.repos.d/cauldron*
'
)

# Make sure /etc/resolv.conf has something useful in it
# This is being done before urpmi.addmedia call to ensure
# that will work from within the chroot...
mkdir -p "$rootfsDir/etc"
cat > "$rootfsDir/etc/resolv.conf" <<'EOF'
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF

# Configure urpmi mirrorlist if urpmi is included on the system
# We do this in within the root to minimize impact from host,
# and so that target system architectures can be properly configured
if [[ $pkgmgr == *"urpmi"* ]]; then
        chroot "$rootfsDir" urpmi.addmedia --curl --distrib --mirrorlist "https://mirrors.mageia.org/api/mageia.$releasever.$buildarch.list"
fi

	cd "$rootfsDir"
rpm --erase basesystem-minimal-core  --root $rootfsDir
dnf autoremove -y \
    --installroot="$rootfsDir" \
    vim-minimal \
    rootfiles tar tcb \
    passwd which psmisc
rpm --erase --nodeps systemd shared-mime-info  --root $rootfsDir
dnf clean all --installroot="$rootfsDir"
rm etc/yum.repos.d/mageia*
	
	# effectively: febootstrap-minimize --keep-zoneinfo --keep-rpmdb --keep-services "$target"
	#  locales
	#  docs
	rm -rf usr/share/{man,doc,info,gnome/help}
	#  cracklib
	rm -rf usr/share/cracklib
	#  i18n
	rm -rf usr/share/i18n
	#  dnf cache
	rm -rf var/cache/dnf
	mkdir -p --mode=0755 var/cache/dnf
	#  sln
	rm -rf sbin/sln
	#  ldconfig
	#rm -rf sbin/ldconfig
	rm -rf etc/ld.so.cache var/cache/ldconfig
	mkdir -p --mode=0755 var/cache/ldconfig

rm -f var/log/*.log
rm -rf var/cache/dnf/*
rm -rf usr/lib/udev
rm -rf usr/lib/.build-id
rm -rf code
rm -rf var/lib/urpmi
rm -rf usr/share/zoneinfo/right
rm -rf usr/lib/kbd
rm -rf etc/udev/hwdb.bin
rm -rf var/lib/rpm/__db.*

pushd sbin
rm -f swap*
rm -f blk*
rm -f fs*
rm -f fdisk
rm -f mkfs*
rm -f mkswap
rm -f losetup
rm -f resizepart
rm -f sfdisk
rm -f sln \
   telinit \
   zramctl \
   shutdown \
   runlevel \
   poweroff \
   reboot \
   addpart \
   agetty \
   blockdev \
   cfdisk \
   clock \
   hwclock \
   halt \
   if* \
   udevadm \
   partx
popd

pushd bin
rm -f halt poweroff
rm -f lsblk \
   lscpu \
   lsipc \
   lsmem \
   partmon \
   rfkill \
   mount \
   nl \
   vdir \
   code2color \
   mkfifo \
   mknod \
   linux32 \
   linux64 \
   setarch \
   fragiso \
   udevadm \
   x86_64
popd

rm -f var/lib/dnf/history*
pushd usr/share/locale
rm -rf `ls | grep -v "^ISO" | grep -v "^UTF" | grep -v "^en" | grep -v "^C.UTF"`
popd

rpm --rebuilddb --root $rootfsDir
if [ "$buildarch" == "x86_64" ] ; then
        rm -f lib/*.so lib/*.so.*
fi	

if [ -d "$rootfsDir/etc/sysconfig" ]; then
        # allow networking init scripts inside the container to work without extra steps
        echo 'NETWORKING=yes' > "$rootfsDir/etc/sysconfig/network"
fi

find $rootfsDir/usr -regex '^.*\(__pycache__\|\.py[co]\)$' -delete

# Docker mounts tmpfs at /dev and procfs at /proc so we can remove them
rm -rf "$rootfsDir/dev" "$rootfsDir/proc"
mkdir -p "$rootfsDir/dev" "$rootfsDir/proc"
chmod 0755 $rootfsDir/dev
chmod 0755 $rootfsDir/proc
chmod 0755 $rootfsDir/var/lib/rpm
chmod 0644 $rootfsDir/var/lib/rpm/*

/usr/sbin/useradd -G wheel -R $rootfsDir user
cat <<EOF > $rootfsDir/etc/sudoers.d/user
%wheel        ALL=(ALL)       NOPASSWD: ALL
EOF
chmod 0755 $rootfsDir/home/user
buildah config --user "user" $container
buildah config --cmd "/bin/bash" $container

buildah commit --format docker --rm $container $name
buildah push $name:latest docker-daemon:$name:latest

