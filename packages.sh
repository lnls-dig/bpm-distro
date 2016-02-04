#!/bin/sh

set -e
set -x

# Group Install packages
GROUPINSTALL_PACKAGES=()
GROUPINSTALL_PACKAGES+=('Core')
GROUPINSTALL_PACKAGES+=('Minimal Install')
GROUPINSTALL_PACKAGES+=('Development Tools')

PACKAGES="net-tools vim git make automake autoconf libtool pkgconfig \
binutils readline perl gcc-c++ python wget glib2 glib2-devel \
uuid-devel readline-devel libusb-devel bzip2-devel libxml2-devel \
perl-XML-Simple selinux-policy yum-utils openssl libdb-utils createrepo \
genisoimage pykickstart kernel kernel-tools kernel-tols-libs kernel-headers \
ntp ntpdate acpid"
