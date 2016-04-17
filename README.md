# Repository containig scripts for customizating the LNLS BPM distribution

The set os scripts located here serves two main purposes:

1. Setup HOST environment for custonmizating a CentOS 7 distribution
2. Generating an ISO image of CentOS 7 with all of our needed packages/softwares

## Generating CentOS image

1. Download a Minimal Centos7 ISO image from one of the following official mirrors:
```
	http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1511.iso
```
2. Install the image in a VM (e.g., VMPlayer or VirtualBox)

3. Burn the image into a USB stick
```
	sudo dd if=<Centos7 Minimal ISO> of=/dev/<usb stick device>
```
4. Plug the USB stick into the VM

5. Alternatively to the step 3 you can mount the image into the VM directly inside the VM
```
	sudo mount -t iso9660 -o loop <Centos7 Minimal ISO> /media/centos-image
```
6. Clone this repository
```
	git clone https://github.com/lnls-dig/bpm-distro.git
```
7. Generate the custom Centos7 image with automated install
```
	./setup-all.sh -i /dev/<centos image device> 2>&1 | tee log.txt
```
8. The image will be created inside kickstart_build/ directory
