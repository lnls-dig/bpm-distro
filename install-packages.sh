#!/bin/sh

set -e
set -x

# Source ackages variables
. ./packages.sh

### Install all packages

# Update database
sudo yum update -y 
# Install CentOS development tools
sudo yum groupinstall -y "${GROUPINSTALL_PACKAGES[@]}"
# Install basic networking tools
sudo yum install -y ${PACKAGES}

# Install specific kernel packages
sudo yum downgrade -y ${KERNEL_PACKAGES}
