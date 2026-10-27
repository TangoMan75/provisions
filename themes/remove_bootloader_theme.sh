#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## TangoMan Bootloader Theme Remover
##
## @license MIT
## @author  "Matthias Morin" <mat@tangoman.io>
## @category themes

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

THEME_DIR=/usr/share/grub/themes
GRUB_CONFIG_FILE=/etc/default/grub

function remove_themes() {
    _echo_warning "Removing theme folder...\n"

    _echo_info "sudo rm -rf \"${THEME_DIR}\"\n"
    sudo rm -rf "${THEME_DIR}"

    _echo_info "sudo mkdir -p \"${THEME_DIR}\"\n"
    sudo mkdir -p "${THEME_DIR}"
}

function config_grub() {
    _echo_success 'Setting grub timeout to 0 second\n'

    # remove default timeout if any
    _echo_info "sudo sed -i '/GRUB_TIMEOUT=/d' \"${GRUB_CONFIG_FILE}\"\n"
    sudo sed -i '/GRUB_TIMEOUT=/d' "${GRUB_CONFIG_FILE}"

    _echo_info "sudo bash -c \"echo 'GRUB_TIMEOUT=\"0\"' >> \"${GRUB_CONFIG_FILE}\"\"\n"
    sudo bash -c "echo 'GRUB_TIMEOUT=\"0\"' >> \"${GRUB_CONFIG_FILE}\""

    _echo_success "Remove theme configuration"
    # remove theme if any
    _echo_info "sudo sed -i '/GRUB_THEME=/d' \"${GRUB_CONFIG_FILE}\"\n"
    sudo sed -i '/GRUB_THEME=/d' "${GRUB_CONFIG_FILE}"
}

function update_grub() {
    # Update grub config
    _echo_success 'Updating grub config...\n'
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
}

function main() {
    _alert_danger 'TangoMan Theme Unnstaller'

    remove_themes

    config_grub
    update_grub
}

main
