#!/bin/sh

set -e
set -x

cd kickstart_build/isolinux
createrepo -g ../comps.xml .
cd ../../
