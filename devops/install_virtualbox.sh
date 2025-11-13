#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## VirtualBox
## virtual machine
##
## @category devops

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

VALID_VERSIONS=(5.2 6.0 6.1 'latest')
VERSION=latest

if [ "$#" -gt 1 ]; then
    echo_danger "error: too many arguments (${#})\n" 2
    echo_success 'usage:' 2 7; echo_primary "$(basename "${0}") -v [version] -h (help)\n"
    exit 1
fi
OPTIND=0
while getopts :v:h OPTION; do
    case "${OPTION}" in
        v) VERSION="${OPTARG}";;
        h) echo_success 'description:' 2 14; echo_primary 'Install php\n'
            echo_success 'usage:' 2 14; echo_primary "$(basename "${0}") -v [version] -h (help)\n"
            exit 0;;
        :) echo_danger "error: \"${OPTARG}\" requires value\n" 2
            exit 1;;
        \?) echo_danger "error: invalid option \"${OPTARG}\"\n" 2
            exit 1;;
    esac
done
for VALID_VERSION in "${VALID_VERSIONS[@]}"; do
    if [ "${VERSION}" = "${VALID_VERSION}" ]; then
        INSTALL=true
    fi
done
if [ "${INSTALL}" != true ]; then
    echo_danger "error: \"$(basename "${0}")\" invalid version \"${VERSION}\"\n" 2
    exit 1
fi

alert_primary "Install VirtualBox ${VERSION}"

echo_info "sudo add-apt-repository --yes \"deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib\"\n"
sudo add-apt-repository --yes "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"

# key for older distributions.
echo_info 'wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -\n'
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

# add key for Debian 8 ("Jessie") / Ubuntu 16.04 ("Xenial") and later
echo_info 'wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -\n'
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -

echo_info 'sudo apt-get -y update\n'
sudo apt-get -y update

if [ "${VERSION}" = '6.1' ] || [ "${VERSION}" = 'latest' ]; then
    echo_info "sudo apt-get install --assume-yes virtualbox\n"
    sudo apt-get install --assume-yes virtualbox
fi

if [ "${VERSION}" = '5.2' ] || [ "${VERSION}" = '6.0' ]; then
    echo_info "sudo apt-get install --assume-yes \"virtualbox-${VERSION}\"\n"
    sudo apt-get install --assume-yes "virtualbox-${VERSION}"

    # if kernel error
    echo_info 'sudo /sbin/vboxconfig\n'
    sudo /sbin/vboxconfig

    echo_info "sudo apt-get install --assume-yes \"linux-headers-$(uname -r)\"\n"
    sudo apt-get install --assume-yes "linux-headers-$(uname -r)"

    echo_info 'sudo apt-get install --assume-yes build-essential\n'
    sudo apt-get install --assume-yes build-essential

    # remove secure boot
    echo_info 'sudo mokutil --disable-validation\n'
    sudo mokutil --disable-validation

    # https://askubuntu.com/questions/760671/could-not-load-vboxdrv-after-upgrade-to-ubuntu-16-04-and-i-want-to-keep-secur
    # https://flavioprimo.xyz/os/how-to-install-virtualbox-on-ubuntu-having-uefi-secure-boot-enabled/
fi

# install extension pack
echo_info 'sudo apt-get install --assume-yes virtualbox-ext-pack\n'
sudo apt-get install --assume-yes virtualbox-ext-pack

# install virtualbox driver
echo_info 'sudo modprobe vboxdrv\n'
sudo modprobe vboxdrv

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/virtualbox.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/virtualbox.desktop "$(xdg-user-dir DESKTOP)"

