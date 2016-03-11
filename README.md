# Repository containig scripts for customizating the LNLS BPM distribution

The set os scripts located here serves two main purposes:

1. Setup HOST environment for custonmizating a CentOS 7 distribution
2. Generating an ISO image of CentOS 7 with all of our needed packages/softwares

## Generating CentOS image

    ./setup-all.sh -i /dev/<centos image device> 2>&1 | tee log.txt
