#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## config grub
##
## @category system

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

OPTIND=0
while getopts :h OPTION; do
    case "${OPTION}" in
        h) _echo_success 'description:' 2 14; _echo_primary "$(basename "${0}"): disable grub splash screen to avoid freeze on boot\n"
            _echo_success 'usage:' 2 14; _echo_primary "$(basename "${0}") -h (help)\n"
            exit 0;;
        \?) _echo_danger "error: invalid option \"${OPTARG}\"\n"
            exit 1;;
    esac
done

_echo_primary 'Enabling grub menu\n'
# remove default grub style if any
_echo_info "sudo sed -i '/GRUB_TIMEOUT_STYLE=/d' /etc/default/grub\n"
sudo sed -i '/GRUB_TIMEOUT_STYLE=/d' /etc/default/grub

_echo_info "sudo bash -c \"echo 'GRUB_TIMEOUT_STYLE=\"menu\"' >> /etc/default/grub\"\n"
sudo bash -c "echo 'GRUB_TIMEOUT_STYLE=\"menu\"' >> /etc/default/grub"

#--------------------------------------------------

_echo_primary 'Setting grub timeout to 1 second\n'
# remove default timeout if any
_echo_info "sudo sed -i '/GRUB_TIMEOUT=/d' /etc/default/grub\n"
sudo sed -i '/GRUB_TIMEOUT=/d' /etc/default/grub

_echo_info "sudo bash -c \"echo 'GRUB_TIMEOUT=\"1\"' >> /etc/default/grub\"\n"
sudo bash -c "echo 'GRUB_TIMEOUT=\"1\"' >> /etc/default/grub"

#--------------------------------------------------

_echo_primary 'Setting grub normal color\n'
# remove default normal color if any
_echo_info "sudo sed -i '/GRUB_COLOR_NORMAL=/d' /etc/default/grub\n"
sudo sed -i '/GRUB_COLOR_NORMAL=/d' /etc/default/grub

_echo_info "sudo bash -c \"echo 'GRUB_COLOR_NORMAL=\"light-gray/magenta\"' >> /etc/default/grub\"\n"
sudo bash -c "echo 'GRUB_COLOR_NORMAL=\"light-gray/magenta\"' >> /etc/default/grub"

#--------------------------------------------------

_echo_primary 'Setting grub highlight color\n'
# remove default highlight color if any
_echo_info "sudo sed -i '/GRUB_COLOR_HIGHLIGHT=/d' /etc/default/grub\n"
sudo sed -i '/GRUB_COLOR_HIGHLIGHT=/d' /etc/default/grub

_echo_info "sudo bash -c \"echo 'GRUB_COLOR_HIGHLIGHT=\"dark-gray/light-magenta\"' >> /etc/default/grub\"\n"
sudo bash -c "echo 'GRUB_COLOR_HIGHLIGHT=\"dark-gray/light-magenta\"' >> /etc/default/grub"

#--------------------------------------------------

_echo_primary 'Setting grub cmdline\n'
# remove default cmdline if any
_echo_info "sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT=/d' /etc/default/grub\n"
sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT=/d' /etc/default/grub

_echo_info "sudo bash -c \"echo 'GRUB_CMDLINE_LINUX_DEFAULT=\"\"' >> /etc/default/grub\"\n"
sudo bash -c "echo 'GRUB_CMDLINE_LINUX_DEFAULT=\"\"' >> /etc/default/grub"

#--------------------------------------------------

_echo_primary 'Setting grub resolution\n'
# remove default normal color if any
_echo_info "sudo sed -i '/GRUB_GFXMODE=/d' /etc/default/grub\n"
sudo sed -i '/GRUB_GFXMODE=/d' /etc/default/grub

_echo_info "sudo bash -c \"echo 'GRUB_GFXMODE=1920x1080' >> /etc/default/grub\"\n"
sudo bash -c "echo 'GRUB_GFXMODE=1920x1080' >> /etc/default/grub"

#--------------------------------------------------

# Update grub config
_echo_primary 'Updating grub config...\n'
if [[ -x "$(command -v update-grub)" ]]; then
    _echo_info 'sudo update-grub\n'
    sudo update-grub

elif [[ -x "$(command -v grub-mkconfig)" ]]; then
    _echo_info 'sudo grub-mkconfig -o /boot/grub/grub.cfg\n'
    sudo grub-mkconfig -o /boot/grub/grub.cfg

elif [[ -x "$(command -v grub2-mkconfig)" ]]; then
    if [[ -x "$(command -v zypper)" ]]; then
        _echo_info 'sudo grub2-mkconfig -o /boot/grub2/grub.cfg\n'
        sudo grub2-mkconfig -o /boot/grub2/grub.cfg

    elif [[ -x "$(command -v dnf)" ]]; then
        _echo_info 'sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg\n'
        sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
    fi
fi
