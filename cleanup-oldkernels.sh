#!/bin/sh

set -e
set -x

# Leave just the most recent kernel
sudo package-cleanup --oldkernels --count=1

# Make sure our all_rpms and Packages folder do not contain
# any kernel pacakges
rm -f kickstart_build/all_rpms/kernel*
rm -f kickstart_build/isolinux/Packages/kernel*
