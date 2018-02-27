#!/bin/sh

set -e
set -x

# Source environment variables
. ./repo-versions.sh

TOP_DIR=$(pwd)

# Setup dirs
mkdir -p kickstart_build/isolinux/postinstall/apps
cd kickstart_build/isolinux/postinstall/apps

# Remove a possibly old tim-rx-app repo
rm -rf tim-rx-app
mkdir tim-rx-app
cd tim-rx-app

# Clone Timing EPICS IOC repo
git clone --recursive --branch=${TIM_RX_VERSION} https://github.com/lnls-dig/tim-rx-epics-ioc

cd ${TOP_DIR}
