#!/bin/sh

set -e
set -x

# Install packages
./install-packages.sh

# Install missing packages from tarballs or from source
./install-re2c.sh

# Setup initscripts
./setup-initscripts.sh

# Setup ISO tree
./setup-iso-tree.sh
