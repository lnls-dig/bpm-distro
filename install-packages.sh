#!/bin/sh

set -e
set -x

# Source ackages variables
. ./packages.sh

### Install all packages

# Update database
sudo yum update -y
# Install CentOS development tools
sudo yum groupinstall -y "${GROUPINSTALL_PACKAGES[@]}" --exclude=kernel*
# Install basic networking tools
sudo yum install -y ${PACKAGES} --exclude=kernel*
