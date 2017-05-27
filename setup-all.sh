#!/bin/sh

set -e
set -x

# Path of device containing Distribution (CentOS 7) install disk
ISO_PATH=

function usage() {
    echo "Usage: $0 [-i <Path to device containing ISO file>]"
}

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

# Ask sudo password only once and
# keep updating sudo timestamp to
# avoid asking again
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || \
    exit; done 2>/dev/null &

### Install packages, scripts and setup ISO tree

# Setup environment
./setup-env.sh

# Install kernel
./install-kernel.sh

# Install packages
./install-packages.sh

# Install missing packages from tarballs or from source
./install-re2c.sh

# Install missing packages from tarballs or from source
./install-arp-scan.sh

# Install missing xorriso package and dependencies from tarballs or from source
./install-xorriso.sh

# Install missing szip from PUIAS repository
./install-szip.sh

# Setup initscripts
./setup-initscripts.sh

# Setup ISO tree
./setup-iso-tree.sh -i ${ISO_PATH}

# Setup BPM app packages
./setup-bpm-app.sh

# Setup BPM distro packages
./setup-bpm-distro.sh

# Fix generated ISO for USB bootable support
./fix-usb-boot-iso.sh

# Setup Repo for building ISO image of distribution
./setup-repo.sh
