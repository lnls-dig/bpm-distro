#!/bin/sh

set -e
set -x

# Specific packages versions
KERNEL_VERSION="4.4.105-1"
KERNEL_VERSION_SUFFIX="el7.elrepo.x86_64"
KERNEL_VERSION_FULL=${KERNEL_VERSION}.${KERNEL_VERSION_SUFFIX}
#KERNEL_DOWNLOAD_URL="http://elrepo.org/linux/kernel/el7/x86_64/RPMS"
KERNEL_DOWNLOAD_URL="ftp.colocall.net/pub/elrepo/archive/kernel/el7/x86_64/RPMS"

# We export these variables as other scripts will use it
export HALCS_KERNEL_DIR=/lib/modules/${KERNEL_VERSION_FULL}/build
export HALCS_DRIVER_INSTALL_DIR=/lib/modules/${KERNEL_VERSION_FULL}/extra
export HALCS_KERNEL_VERSION=${KERNEL_VERSION_FULL}

# Package versions
FEDORA_ISO_UTILS_REPO_URL=http://archives.fedoraproject.org/pub/archive/epel/5/x86_64
EPEL_6_REPO_URL=http://dl.fedoraproject.org/pub/epel/6/x86_64/Packages
RE2C_VERSION=0.13.5-1
ARP_SCAN_VERSION=1.9.2-1
SZIP_VERSION=2.1-1
XORRISO_VERSION=1.4.6-1
LIBBURN_VERSION=1.4.6-1
LIBISOBURN_VERSION=1.4.6-1
LIBISOFS_VERSION=1.4.6-1

# BPM versions
BPM_DISTRO_VERSION=master
BPM_APP_VERSION=master
