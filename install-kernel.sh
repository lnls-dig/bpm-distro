#!/bin/sh

set -e
set -x

. ./repo-versions.sh

# Cleanup kernels
./cleanup-oldkernels.sh

# Change to RPM directory
cd kickstart_build/all_rpms

# Download desired kernel versions
wget ${KERNEL_DOWNLOAD_URL}/kernel-lt-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm
wget ${KERNEL_DOWNLOAD_URL}/kernel-lt-devel-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm
wget ${KERNEL_DOWNLOAD_URL}/kernel-lt-doc-${KERNEL_VERSION}.el7.elrepo.noarch.rpm
wget ${KERNEL_DOWNLOAD_URL}/kernel-lt-headers-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm
wget ${KERNEL_DOWNLOAD_URL}/kernel-lt-tools-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm
wget ${KERNEL_DOWNLOAD_URL}/kernel-lt-tools-libs-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm
wget ${KERNEL_DOWNLOAD_URL}/kernel-lt-tools-libs-devel-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm

# Install them
sudo rpm -Uvh --oldpackage --replacepkgs kernel-lt-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm
sudo rpm -Uvh --oldpackage --replacepkgs kernel-lt-devel-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm
sudo rpm -Uvh --oldpackage --replacepkgs kernel-lt-doc-${KERNEL_VERSION}.el7.elrepo.noarch.rpm
sudo rpm -Uvh --oldpackage --replacepkgs kernel-lt-headers-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm
sudo rpm -Uvh --oldpackage --replacepkgs kernel-lt-tools-libs-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm
sudo rpm -Uvh --oldpackage --replacepkgs kernel-lt-tools-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm
sudo rpm -Uvh --oldpackage --replacepkgs kernel-lt-tools-libs-devel-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm

cd ../../
