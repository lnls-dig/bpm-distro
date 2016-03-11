#!/bin/sh

set -e
set -x

# This was based on a serverfault answer:
# serverfault.com/questions/549121/kickstart-installation-from-usb-kickstart-location
mkdir -p irmod
cd irmod

# Extract initdrd into irmod
xz -d < ../kickstart_build/isolinux/isolinux/initrd.img | sudo cpio --extract --make-directories --no-absolute-filenames

# Create special folder for our ks.cfg file
mkdir ks

# Add ks file to initrd
cp ../kickstart_build/isolinux/ks/ks.cfg ks/

# Recreate initrd.img
find . | cpio -H newc --create | xz --format=lzma --compress --stdout > initrd.img 

sudo mv initrd.img ../kickstart_build/isolinux/isolinux/initrd.img

# Cleanup
cd ..
sudo rm -rf irmod
