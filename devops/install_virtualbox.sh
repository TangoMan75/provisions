#!/bin/bash

#/**
# * virtualbox
# * virtual machine
# *
# * @category devops
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ "${#}" -gt 1 ]; then
    echo_error "too many arguments (${#})"
    echo_label 'usage'; echo_primary "`basename ${0}` -n (no update) -h (help)"
    exit 1
fi

VERSION=latest

OPTIND=0
while getopts :nh OPTION; do
    case "${OPTION}" in
        n) UPDATE='false';;
        h) echo_label 'description'; echo_primary "`basename ${0}`"
            echo_label 'usage'; echo_primary "`basename ${0}` -n (no update) -h (help)"
            exit 0;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done

# check valid version
INSTALL='false'
for VALID_VERSION in 5.2 6.0 6.1 'latest'; do
    if [ "${VERSION}" = "${VALID_VERSION}" ]; then
        INSTALL='true'
    fi
done

if [ "${INSTALL}" = 'false' ]; then
    echo_error "Cannot install VirtualBox \"${VERSION}\", invalid version"
    exit 1
fi

if [ "${UPDATE}" != 'false' ]; then
    if [ `is_installed 'wget'` == 'false' ]; then
        echo_error "\"`basename ${0}`\" requires wget, try: 'sudo apt-get install -y wget'"
        exit 1
    fi

    echo_info "sudo add-apt-repository \"deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian `lsb_release -cs` contrib\""
    sudo add-apt-repository "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian `lsb_release -cs` contrib"

    # key for older distributions.
    echo_info 'wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -'
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

    # add key for Debian 8 ("Jessie") / Ubuntu 16.04 ("Xenial") and later
    echo_info 'wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -'
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -

    echo_info 'sudo apt-get -y update'
    sudo apt-get -y update
fi

if [ "${VERSION}" = '6.1' ] || [ "${VERSION}" = 'latest' ]; then
    echo_info "sudo apt-get install --assume-yes virtualbox"
    sudo apt-get install --assume-yes virtualbox
fi

if [ "${VERSION}" = '5.2' ] || [ "${VERSION}" = '6.0' ]; then
    echo_info "sudo apt-get install --assume-yes virtualbox-${VERSION}"
    sudo apt-get install --assume-yes virtualbox-${VERSION}

    # if kernel error
    echo_info 'sudo /sbin/vboxconfig'
    sudo /sbin/vboxconfig

    echo_info "sudo apt-get install --assume-yes linux-headers-$(uname -r)"
    sudo apt-get install --assume-yes linux-headers-$(uname -r)

    echo_info 'sudo apt-get install --assume-yes build-essential'
    sudo apt-get install --assume-yes build-essential

    # remove secure boot
    echo_info 'sudo mokutil --disable-validation'
    sudo mokutil --disable-validation

    # https://askubuntu.com/questions/760671/could-not-load-vboxdrv-after-upgrade-to-ubuntu-16-04-and-i-want-to-keep-secur
    # https://flavioprimo.xyz/os/how-to-install-virtualbox-on-ubuntu-having-uefi-secure-boot-enabled/
fi

echo_info 'sudo apt-get install --assume-yes virtualbox-ext-pack'
sudo apt-get install --assume-yes virtualbox-ext-pack

echo_info 'sudo modprobe vboxdrv'
sudo modprobe vboxdrv

# create desktop shortcut
cat > ~/Desktop/virtualbox.desktop<<EOF
[Desktop Entry]
Name=VirtualBox
GenericName=PC virtualization solution
Type=Application
Exec=VirtualBox %U
Keywords=virtualization;
Icon=virtualbox
Categories=Emulator;System;Utility;
Comment=Run several virtual systems on a single host computer
EOF
