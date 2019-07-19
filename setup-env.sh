#!/bin/sh

set -e
set -x

# Setup elrepo repository
sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
sudo rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm || /bin/true

# Setup Zabbix repository
sudo pm -Uvh https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-1.el7.noarch.rpm || /bin/true

# Write kernel version to repo-versions.sh file
KERNEL_VERSION=$(repoquery --enablerepo=elrepo-kernel kernel-lt | sed -e "s/kernel-lt-0:\([0-9]*.[0-9]*.[0-9]*-[0-9]\).*/\1/g")

sed -i -e "s/<INSERT_KERNEL_VERSION>/${KERNEL_VERSION}/g" repo-versions.sh

# Reinstall cerificates in case of old repo. let's encrypt might not be there.
sudo yum -y reinstall ca-certificates
