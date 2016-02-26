#!/bin/sh

set -e
set -x

PWD=$(pwd)

# Setup dirs
mkdir -p kickstart_build/isolinux/postinstall/apps
cd kickstart_build/isolinux/postinstall/apps

# Clone BPM App repo
git clone https://github.com/lnls-dig/bpm-app

# Download the repos, but don't install them
cd bpm-app
./get-all.sh -r server -b afcv3_1 -a yes -e yes -o

cd ${PWD}
