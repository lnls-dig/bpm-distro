#!/bin/sh

set -e
set -x

# Group Install packages
GROUPINSTALL_PACKAGES=()
GROUPINSTALL_PACKAGES+=('Core')
GROUPINSTALL_PACKAGES+=('Minimal Install')
GROUPINSTALL_PACKAGES+=('Development Tools')

PACKAGES="net-tools vim git make automake autoconf libtool pkgconfig \
binutils readline perl gcc gcc-c++ python wget glib2 glib2-devel \
uuid-devel readline-devel libusb-devel bzip2-devel libpng12-devel libxml2-devel \
ncurses-devel perl-XML-Simple selinux-policy yum-utils openssl libdb-utils createrepo \
genisoimage pykickstart kernel kernel-tools kernel-tools-libs kernel-headers \
ntp ntpdate acpid libusb-devel bash-completion perl-ExtUtils-* perl-Pod-Checker \
perl-Pod-Parser iptables-services "


# EPICS dependencies
PACKAGES+="libstdc++-devel lapack freetype-devel fontconfig-devel \
libjpeg-turbo-devel libtiff-devel giflib-devel libcurl-devel flex \
libX11-devel libXext-devel libXaw-devel libXp-devel "
