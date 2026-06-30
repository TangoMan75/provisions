#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## VirtualBox
## virtual machine
##
## NOTE: - version 5.2 is deprecated, apt cannot find install candidate
##       - version 7.0+ have a bug and cannot install properly
##       - version 6.1 is the only working version for ubuntu as far as I know
##       - You will probably need to disable UEFI to have it work properly
##         `sudo mokutil --disable-validation`
##         OR sign drivers with `config_virtualbox.sh` which is not tested
##         at the moment of writing
##         AND disable KVM `sudo modprobe -r kvm_intel && sudo modprobe -r kvm`
##
## @category devops
## @link     https://www.virtualbox.org

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

VALID_VERSIONS=(5.2 6.0 6.1 7.0 7.1 7.2 latest)
VERSION=6.1
DESKTOP=virtualbox.desktop

#--------------------------------------------------

if [ "$#" -gt 1 ]; then
    _echo_danger "error: too many arguments (${#})\n" 2
    _echo_success 'usage:' 2 7; _echo_primary "$(basename "${0}") -v [version] -h (help)\n"
    exit 1
fi
OPTIND=0
while getopts :v:h OPTION; do
    case "${OPTION}" in
        v) VERSION="${OPTARG}";;
        h) _echo_success 'description:' 2 14; _echo_primary 'Install virtualbox\n'
            _echo_success 'usage:' 2 14; _echo_primary "$(basename "${0}") -v [version] -h (help)\n"
            exit 0;;
        :) _echo_danger "error: \"${OPTARG}\" requires value\n" 2
            exit 1;;
        \?) _echo_danger "error: invalid option \"${OPTARG}\"\n" 2
            exit 1;;
    esac
done
for VALID_VERSION in "${VALID_VERSIONS[@]}"; do
    if [ "${VERSION}" = "${VALID_VERSION}" ]; then
        INSTALL=true
    fi
done
if [ "${INSTALL}" != true ]; then
    _echo_danger "error: \"$(basename "${0}")\" invalid version \"${VERSION}\"\n" 2
    exit 1
fi

#--------------------------------------------------

_alert_primary "Install VirtualBox ${VERSION}"

#--------------------------------------------------

_echo_info "sudo add-apt-repository --yes \"deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib\"\n"
sudo add-apt-repository --yes "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"

_echo_info 'wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -\n'
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -

#--------------------------------------------------

_echo_info 'sudo apt-get -y update\n'
sudo apt-get -y update

#--------------------------------------------------

# prevent service start during install
# The install fails because the service tries to load vboxdrv immediately, but Secure Boot or missing headers block it.
# Masking the service during install, then rebuilding and signing modules manually, breaks the loop.
_echo_info 'sudo systemctl mask virtualbox.service\n'
sudo systemctl mask virtualbox.service

#--------------------------------------------------

if [ "${VERSION}" = '5.2' ] || [ "${VERSION}" = '6.0' ]; then
    _echo_info "sudo apt-get install --assume-yes \"virtualbox-${VERSION}\"\n"
    sudo apt-get install --assume-yes "virtualbox-${VERSION}"

    # if kernel error
    _echo_info 'sudo /sbin/vboxconfig\n'
    sudo /sbin/vboxconfig

    _echo_info "sudo apt-get install --assume-yes \"linux-headers-$(uname -r)\"\n"
    sudo apt-get install --assume-yes "linux-headers-$(uname -r)"

    _echo_info 'sudo apt-get install --assume-yes build-essential\n'
    sudo apt-get install --assume-yes build-essential

    # https://askubuntu.com/questions/760671/could-not-load-vboxdrv-after-upgrade-to-ubuntu-16-04-and-i-want-to-keep-secur
    # https://flavioprimo.xyz/os/how-to-install-virtualbox-on-ubuntu-having-uefi-secure-boot-enabled/
fi

if [ "${VERSION}" = 'latest' ]; then
    _echo_info "sudo apt-get install --assume-yes virtualbox\n"
    sudo apt-get install --assume-yes virtualbox
else
    _echo_info "sudo apt-get install --assume-yes \"virtualbox-${VERSION}\"\n"
    sudo apt-get install --assume-yes "virtualbox-${VERSION}"
fi

#--------------------------------------------------

_echo_info 'sudo systemctl unmask virtualbox.service\n'
sudo systemctl unmask virtualbox.service

#--------------------------------------------------

_echo_warning 'Install extension pack\n'

# Key Features of VirtualBox Extension Pack
# USB 2.0/3.0 support: Enables virtual machines to use modern USB devices directly.
# VirtualBox Remote Desktop Protocol (VRDP): Allows remote access to VMs using RDP.
# Host webcam passthrough: Lets guest systems access the host’s webcam.
# Disk image encryption: Adds support for encrypting VM disk images.
# PXE boot for Intel cards: Useful for network booting virtual machines.
# NVMe and PCI passthrough: Advanced hardware support for better performance and integration.

_echo_info 'sudo apt-get install --assume-yes virtualbox-ext-pack\n'
sudo apt-get install --assume-yes virtualbox-ext-pack

#--------------------------------------------------

_echo_warning 'Load VirtualBox driver\n'

_echo_info 'sudo modprobe vboxdrv\n'
sudo modprobe vboxdrv

#--------------------------------------------------

_echo_warning 'Create shortcut on desktop\n'

_echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

