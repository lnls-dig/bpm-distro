#!/bin/sh

set -e
set -x

RE2C_VERSION=0.13.5-1

# Download RPM
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/re2c-${RE2C_VERSION}.el6.x86_64.rpm

# Install it
sudo rpm -Uvh --replacepkgs re2c-${RE2C_VERSION}.el6.x86_64.rpm
