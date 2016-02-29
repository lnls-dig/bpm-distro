#!/bin/sh

set -e
set -x

RE2C_VERSION=0.13.5-1

# Download RPM
wget pkgs.repoforge.org/re2c/re2c-${RE2C_VERSION}.el6.rf.x86_64.rpm

# Install it
sudo rpm -Uvh --replacepkgs re2c-${RE2C_VERSION}*.rpm
