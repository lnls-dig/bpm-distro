#!/bin/sh

set -e
set -x

RE2C_VERSION=0.14.3

# Download tarball
wget https://github.com/skvadrik/re2c/releases/download/${RE2C_VERSION}/re2c-${RE2C_VERSION}.tar.gz

# Extract
tar xzvf re2c-${RE2C_VERSION}.tar.gz

# Change directory
cd re2c-${RE2C_VERSION}

# Install
./configure && make && sudo make install

# Go back
cd ../
