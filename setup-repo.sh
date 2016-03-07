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
mkisofs -o lnls-bpm-centos7.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot \
    -V 'CentOS 7 x86_64' \
    -boot-load-size 4 -boot-info-table -R -J -v isolinux/
