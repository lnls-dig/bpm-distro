#!/bin/sh

set -e
set -x

. ./repo-versions.sh

# Group Install packages
GROUPINSTALL_PACKAGES=()
GROUPINSTALL_PACKAGES+=('Core')
GROUPINSTALL_PACKAGES+=('Minimal Install')
GROUPINSTALL_PACKAGES+=('Development Tools')

PACKAGES="net-tools vim git make automake autoconf libtool pkgconfig \
binutils readline perl gcc gcc-c++ python wget glib2 glib2-devel \
uuid-devel readline-devel libusb-devel bzip2-devel libpng12-devel libxml2-devel \
ncurses-devel perl-XML-Simple selinux-policy yum-utils openssl libdb-utils createrepo \
genisoimage pykickstart ntp ntpdate acpid libusb-devel bash-completion \
perl-ExtUtils-* perl-Pod-Checker perl-Pod-Parser iptables-services syslinux \
pciutils telnet psmisc valgrind dracut systemd-libs systemd dracut-network libgudev1 \
firewalld-filsystem python-firewall \
systemd-sysv cryptsetup cryptsetup-libs expat libgcc libgomp libstdc++ java-1.8.0-openjdk "

# EPICS dependencies
PACKAGES+="libstdc++-devel lapack freetype-devel fontconfig-devel \
libjpeg-turbo-devel libtiff-devel giflib-devel libcurl-devel flex \
libX11-devel libXext-devel libXaw-devel libXp-devel hdf5-devel ImageMagick \
ImageMagick-devel "

# Kernel Packages. These are install separatly by install-kernel.sh script
#KERNEL_PACKAGES="kernel-${KERNEL_VERSION} kernel-tools-${KERNEL_VERSION} \
#kernel-tools-libs-${KERNEL_VERSION} kernel-headers-${KERNEL_VERSION} \
#kernel-devel-${KERNEL_VERSION} "
