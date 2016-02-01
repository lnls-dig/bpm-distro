#!/bin/sh -v

set -e
set -x

# Copy initscript to correct location
sudo cp initscripts/net-autostart /etc/init.d

# Add script for autostart
sudo chkconfig --add net-autostart
