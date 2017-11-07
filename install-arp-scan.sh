#!/bin/sh

set -e
set -x

. ./repo-versions.sh

# Change to RPM directory
cd kickstart_build/all_rpms

# Download RPM
wget ${EPEL_6_REPO_URL}/a/arp-scan-${ARP_SCAN_VERSION}.el6.x86_64.rpm

# Remove arp-scan that may be already installed
sudo yum remove -y arp-scan

# Install it
sudo rpm -Uvh --replacepkgs arp-scan-${ARP_SCAN_VERSION}.el6.x86_64.rpm

cd ../../
