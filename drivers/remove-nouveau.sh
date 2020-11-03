#!/bin/bash

#/**
# * remove-nouveau
# *
# * @category drivers
# * @license  MIT
# * @author   "Matthias Morin" <mat@tangoman.io>
# * @link     https://docs.kali.org/general-use/install-nvidia-drivers-on-kali-linux
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

# disable nouveau
echo_info 'echo -e "blacklist nouveau\noptions nouveau modeset=0\nalias nouveau off" > /etc/modprobe.d/blacklist-nouveau.conf'
echo -e "blacklist nouveau\noptions nouveau modeset=0\nalias nouveau off" > /etc/modprobe.d/blacklist-nouveau.conf

# update-initramfs
echo_info 'update-initramfs -u'
update-initramfs -u

# check nouveau is disabled
echo_info 'lsmod | grep -i nouveau'
lsmod | grep -i nouveau
