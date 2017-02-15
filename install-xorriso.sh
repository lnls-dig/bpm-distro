#!/bin/sh

set -e
set -x

. ./repo-versions.sh

# Change to RPM directory
cd kickstart_build/all_rpms

# Download Repoforge
wget http://dl.fedoraproject.org/pub/epel/5/x86_64/libisofs-${LIBISOFS_VERSION}.el5.x86_64.rpm
wget http://dl.fedoraproject.org/pub/epel/5/x86_64/libburn-${LIBBURN_VERSION}.el5.x86_64.rpm
wget http://dl.fedoraproject.org/pub/epel/5/x86_64/libisoburn-${LIBISOBURN_VERSION}.el5.x86_64.rpm
wget http://dl.fedoraproject.org/pub/epel/5/x86_64/xorriso-${XORRISO_VERSION}.el5.x86_64.rpm

# Remove xorriso that may be already installed
sudo yum remove -y libisofs
sudo yum remove -y libburn
sudo yum remove -y libisoburn
sudo yum remove -y xorriso

# Install it
sudo rpm -Uvh --replacepkgs libisofs-${LIBISOFS_VERSION}.el5.x86_64.rpm
sudo rpm -Uvh --replacepkgs libburn-${LIBBURN_VERSION}.el5.x86_64.rpm
sudo rpm -Uvh --replacepkgs libisoburn-${LIBISOBURN_VERSION}.el5.x86_64.rpm
sudo rpm -Uvh --replacepkgs xorriso-${XORRISO_VERSION}.el5.x86_64.rpm

cd ../../
