#!/bin/sh

set -e
set -x

. ./repo-versions.sh

# Cleanup kernels
./cleanup-oldkernels.sh

# Change to RPM directory
cd kickstart_build/all_rpms

# Download desired kernel versions
wget http://elrepo.org/linux/kernel/el7/x86_64/RPMS/kernel-lt-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm
wget http://elrepo.org/linux/kernel/el7/x86_64/RPMS/kernel-lt-devel-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm
wget http://elrepo.org/linux/kernel/el7/x86_64/RPMS/kernel-lt-doc-${KERNEL_VERSION}.el7.elrepo.noarch.rpm
wget http://elrepo.org/linux/kernel/el7/x86_64/RPMS/kernel-lt-headers-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm
wget http://elrepo.org/linux/kernel/el7/x86_64/RPMS/kernel-lt-tools-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm
wget http://elrepo.org/linux/kernel/el7/x86_64/RPMS/kernel-lt-tools-libs-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm
wget http://elrepo.org/linux/kernel/el7/x86_64/RPMS/kernel-lt-tools-libs-devel-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm

# Install them
sudo rpm -Uvh kernel-lt-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm
sudo rpm -Uvh kernel-lt-devel-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm
sudo rpm -Uvh kernel-lt-doc-${KERNEL_VERSION}.el7.elrepo.noarch.rpm
sudo rpm -Uvh kernel-lt-headers-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm
sudo rpm -Uvh kernel-lt-tools-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm
sudo rpm -Uvh kernel-lt-tools-libs-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm
sudo rpm -Uvh kernel-lt-tools-libs-devel-${KERNEL_VERSION}.el7.elrepo.x86_64.rpm

cd ../../
