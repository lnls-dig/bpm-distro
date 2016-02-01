#!/bin/sh

set -e
set -x

YUM_DOWNLOADONLY="--downloadonly --downloaddir=kickstart_build/all_rpms/"

# Source ackages variables
. ./packages.sh

### Run everything "download only" first so we have all packages 
### in a single place

# Update database
sudo yum update -y ${YUM_DONWLOADONLY}
# Install CentOS development tools
sudo yum groupinstall -y ${YUM_DONWLOADONLY} ${GROUPINSTALL_PACKAGES[@]} 
# Install basic networking tools
sudo yum install -y ${YUM_DONWLOADONLY} ${PACKAGES} 

### Install everything normally

# Update database
sudo yum update -y 
# Install CentOS development tools
sudo yum groupinstall -y ${GROUPINSTALL_PACKAGES[@]} 
# Install basic networking tools
sudo yum install -y ${PACKAGES} 
