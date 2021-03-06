#!/bin/sh

set -e
set -x

# Leave just the most recent kernel
sudo package-cleanup -y --oldkernels --count=1
sudo yum remove -y kernel-headers kernel-lt-headers
sudo yum remove -y kernel-tools kernel-lt-tools
sudo yum remove -y kernel-tools-libs kernel-lt-tools-libs

# Make sure our all_rpms and Packages folder do not contain
# any kernel pacakges
rm -f kickstart_build/all_rpms/kernel*
rm -f kickstart_build/isolinux/Packages/kernel*
