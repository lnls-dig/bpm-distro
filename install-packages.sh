#!/bin/sh -v

set -e
set -x

# Update database
sudo yum update -y

# Install CentOS basic packages
sudo yum groupinstall -y "Basic"

# Install CentOS development tools
sudo yum groupinstall -y "Development Tools"

# Install basic networking tools
sudo yum install -y net-tools

# Install utilities
sudo yum install -y vim git make automake autoconf libtool pkgconfig \
binutils readline perl gcc-c++ python wget glib2 glib2-devel \
uuid-devel readline-devel libusb-devel bzip2-devel libxml2-devel

# Install security packages
sudo yum install -y selinux-policy
