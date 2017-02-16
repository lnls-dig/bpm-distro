#!/bin/sh

set -e
set -x

# Source environment variables
. ./repo-versions.sh

TOP_DIR=$(pwd)

# Setup dirs
mkdir -p kickstart_build/isolinux/postinstall/apps
cd kickstart_build/isolinux/postinstall/apps

# Remove a possibly old bpm-distro repo
rm -rf bpm-distro

# Clone BPM Distro repo
# Download the repos, for future reference.
# This is good so we now exactly how we generated
# the target image
git clone --recursive --branch=${BPM_DISTRO_VERSION} https://github.com/lnls-dig/bpm-distro

cd ${TOP_DIR}
