#!/bin/sh

set -e
set -x

# Setup DBs
cd kickstart_build/isolinux
createrepo -g ../comps.xml .
cd ../../

# Build ISO
cd kickstart_build
chmod 644 isolinux/isolinux/isolinux.bin
xorriso -as mkisofs -v -R -J -joliet-long -V "CentOS 7 x86_64" -o "lnls-bpm-centos7.iso" \
   -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4  \
   -boot-info-table -isohybrid-mbr /usr/share/syslinux/isohdpfx.bin isolinux
