#!/bin/sh

set -e
set -x

USER=$(whoami)
HOST_ARCH=x86_64
MOUNT_POINT=/media/centos-install-disk

function usage() {
    echo "Usage: $0 [-i <Path to device containing ISO file>]"
}

# Path of device containing Distribution (CentOS 7) install disk
ISO_PATH=

# Get command-line options
while getopts ":i:" opt; do
    case "${opt}" in
        i)
            ISO_PATH=${OPTARG}
            ;;
        \?) 
            echo "Invalid option: $OPTARG" >&2
            exit 1
            ;;
        :) 
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))

# Check if argument was set
if [ -z "${ISO_PATH}" ]; then
    usage
    exit 1;
fi

# Mount install disk
sudo mkdir -p ${MOUNT_POINT}
# Unmmount unit if it's already mounted. Ignore error if mounted
sudo umount ${ISO_PATH} || /bin/true
sudo mount ${ISO_PATH} ${MOUNT_POINT}

### From this point on, the isntructions were extract from 
### www.smorgasbork.com/2014/07/16/building-a-custom-centos-7-kickstart-disc-part-1/

### Don't remove everything by default. We rely on already setup config files
## Remove all files for precaution. We want to start cleanly
#rm -rf kickstart_build

# Exclude isolinux directory contents (including hidden files) as this should be 
# copied as is from disk image. 
cd kickstart_build
# Remove protected images folder first
sudo rm -rf isolinux/images
sudo rm -rf isolinux/EFI
find isolinux -type f -not -name "ks.cfg" -not -name "isolinux.cfg" -not -name ".keepme" -exec rm -f "{}" \;
cd ../

# Create kickstart tree
mkdir -p kickstart_build/{isolinux/{isolinux,images,ks,LiveOS,EFI,Packages},utils,all_rpms}

# Copy files into created structure
find ${MOUNT_POINT}/isolinux/ -type f -not -name "isolinux.cfg" -exec cp "{}" kickstart_build/isolinux/isolinux \;
cp ${MOUNT_POINT}/.discinfo kickstart_build/isolinux/
cp -r ${MOUNT_POINT}/images/* kickstart_build/isolinux/images
cp -r ${MOUNT_POINT}/EFI/* kickstart_build/isolinux/EFI
cp -r ${MOUNT_POINT}/LiveOS/* kickstart_build/isolinux/LiveOS

# Copy ISO packages into local folder
sudo cp ${MOUNT_POINT}/Packages/* kickstart_build/all_rpms/
# Change permissions
sudo chmod -R 755 kickstart_build/all_rpms/
sudo chown -R ${USER}:${USER} kickstart_build/all_rpms/

# Download oll of our installed packages
cd kickstart_build/all_rpms/
rpm -qa | \
# Exclude gpg-pubkey* fake packages
sed -e "s/^gpg-pubkey.*//g" > \
installed_packages; while read -r package; do COMMAND="sudo yumdownloader --resolve ${package}"; echo "${COMMAND}"; eval ${COMMAND}; done < installed_packages
rm installed_packages
cd ../../

### Don't get default script from site. This is already available in 
### kickstart_build/utils/gather_pacakges.pl
## Get script to parse comps.xml
#wget www.smorgasbork.com/content/gather_packages.txt
#mv gather_packages.txt kickstart_build/utils/gather_packages.pl

### Don't use default comps.xml package. Use our own
## Copy and gunzip comps.xml
#cp ${MOUNT_POINT}/repodata/*c7-x86_64-comps.xml.gz kickstart_build/comps.xml.gz
#cd kickstart_build
#gunzip comps.xml.gz
#cd ..
#
## Copy default config file from local machine
#sudo cp /root/anaconda-ks.cfg kickstart_build/isolinux/ks/ks.cfg
#
## Change permissions
#sudo chmod 755 kickstart_build/isolinux/ks/ks.cfg
#sudo chown ${USER}:${USER} kickstart_build/isolinux/ks/ks.cfg

# Copy packages specified in file comps.xml to Packages directory. They 
# must reside in all_rpms directory
kickstart_build/utils/gather_packages.pl kickstart_build/comps.xml \
kickstart_build/all_rpms kickstart_build/isolinux/Packages ${HOST_ARCH}

# Copy package dependencies into Packages directory. They must reside in 
# all_rpms directory
kickstart_build/utils/resolve_deps.pl \
kickstart_build/all_rpms kickstart_build/isolinux/Packages ${HOST_ARCH}

# Testing the dependencies
cd kickstart_build/isolinux/Packages
mkdir -p /tmp/testdb
rpm --initdb --dbpath /tmp/testdb
rpm --test --dbpath /tmp/testdb -Uvh *.rpm
cd ../../../

# Test if kickstart file is valid
ksvalidator kickstart_build/isolinux/ks/ks.cfg || exit 1
