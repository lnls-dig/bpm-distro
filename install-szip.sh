#!/bin/sh

set -e
set -x

SZIP_VERSION=2.1.1

# Change to RPM directory
cd kickstart_build/all_rpms

# Download RPM
wget http://springdale.math.ias.edu/data/puias/computational/7/x86_64//szip-$(SZIP_VERSION).sdl7.x86_64.rpm

# Remove re2c that may be already installed
sudo yum remove -y szip

# Install it
sudo rpm -Uvh --replacepkgs szip-${SZIP_VERSION}.sdl7.x86_64.rpm

cd ../../
