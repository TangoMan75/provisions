#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * virtualbox
# * virtual machine
# *
# * @category devops
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

VALID_VERSIONS=(5.2 6.0 6.1 'latest')
VERSION=latest

if [ "$#" -gt 1 ]; then
    echo_error "too many arguments (${#})"
    echo_label 3 'usage'; echo_primary "$(basename "${0}") -v [version] -h (help)"
    exit 1
fi
OPTIND=0
while getopts :v:h OPTION; do
    case "${OPTION}" in
        v) VERSION="${OPTARG}";;
        h) echo_label 12 'description'; echo_primary 'Install php'
            echo_label 12 'usage'; echo_primary "$(basename "${0}") -v [version] -h (help)"
            exit 0;;
        :) echo_error "\"${OPTARG}\" requires value"
            exit 1;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done
for VALID_VERSION in "${VALID_VERSIONS[@]}"; do
    if [ "${VERSION}" = "${VALID_VERSION}" ]; then
        INSTALL=true
    fi
done
if [ "${INSTALL}" != true ]; then
    echo_error "\"$(basename "${0}")\" invalid version \"${VERSION}\""
    exit 1
fi

alert_primary "Install virtualbox ${VERSION}"

echo_info "sudo add-apt-repository \"deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib\""
sudo add-apt-repository "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"

# key for older distributions.
echo_info 'wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -'
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

# add key for Debian 8 ("Jessie") / Ubuntu 16.04 ("Xenial") and later
echo_info 'wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -'
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -

echo_info 'sudo apt-get -y update'
sudo apt-get -y update

if [ "${VERSION}" = '6.1' ] || [ "${VERSION}" = 'latest' ]; then
    echo_info "sudo apt-get install --assume-yes virtualbox"
    sudo apt-get install --assume-yes virtualbox
fi

if [ "${VERSION}" = '5.2' ] || [ "${VERSION}" = '6.0' ]; then
    echo_info "sudo apt-get install --assume-yes \"virtualbox-${VERSION}\""
    sudo apt-get install --assume-yes "virtualbox-${VERSION}"

    # if kernel error
    echo_info 'sudo /sbin/vboxconfig'
    sudo /sbin/vboxconfig

    echo_info "sudo apt-get install --assume-yes \"linux-headers-$(uname -r)\""
    sudo apt-get install --assume-yes "linux-headers-$(uname -r)"

    echo_info 'sudo apt-get install --assume-yes build-essential'
    sudo apt-get install --assume-yes build-essential

    # remove secure boot
    echo_info 'sudo mokutil --disable-validation'
    sudo mokutil --disable-validation

    # https://askubuntu.com/questions/760671/could-not-load-vboxdrv-after-upgrade-to-ubuntu-16-04-and-i-want-to-keep-secur
    # https://flavioprimo.xyz/os/how-to-install-virtualbox-on-ubuntu-having-uefi-secure-boot-enabled/
fi

# install extension pack
echo_info 'sudo apt-get install --assume-yes virtualbox-ext-pack'
sudo apt-get install --assume-yes virtualbox-ext-pack

# install virtualbox driver
echo_info 'sudo modprobe vboxdrv'
sudo modprobe vboxdrv

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/virtualbox.desktop \"$(xdg-user-dir DESKTOP)\""
cp -p /usr/share/applications/virtualbox.desktop "$(xdg-user-dir DESKTOP)"

