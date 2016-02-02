#!/bin/sh

set -e
set -x

USER=$(whoami)
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
# copied as is from disk image. Ignore stderr (errors from directories starting with '.')
rm -rf kickstart_build/isolinux/

# Create kickstart tree
mkdir -p kickstart_build/{isolinux/{images,ks,LiveOS,Packages},utils,all_rpms}

# Copy files into created structure
cp -r ${MOUNT_POINT}/isolinux/* kickstart_build/isolinux/
cp ${MOUNT_POINT}/.discinfo kickstart_build/isolinux/
cp -r ${MOUNT_POINT}/LiveOS/* kickstart_build/isolinux/LiveOS

# Copy ISO packages into local folder
cp ${MOUNT_POINT}/Packages/* kickstart_build/all_rpms/ || /bin/true

# Download oll of our installed packages
cd kickstart_build/all_rpms/
rpm -qa | \
# Exclude gpg-pubkey* fake packages
sed -e "s/^gpg-pubkey.*//g" > \
installed_packages; while read -r package; do sudo yumdownloader ${package}; done < installed_packages
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
