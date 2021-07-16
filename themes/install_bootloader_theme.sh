#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * TangoMan Bootloader Theme Installer
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# * @category themes
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

THEME_SOURCE=${CURDIR}/bootloader-themes
THEME_DIR=/usr/share/grub/themes
THEME_NAME=CyberRe

function install_theme() {
    # create themes directory if not exists
    if [[ ! -d "${THEME_DIR}/${THEME_NAME}" ]]; then
        # Copy theme
        echo_primary "Installing ${THEME_NAME} theme..."

        echo_info "sudo mkdir -p \"${THEME_DIR}/${THEME_NAME}\""
        sudo mkdir -p "${THEME_DIR}/${THEME_NAME}"

        echo_info "sudo cp -a \"${THEME_SOURCE}/${THEME_NAME}\"/* \"${THEME_DIR}/${THEME_NAME}\""
        sudo cp -a "${THEME_SOURCE}/${THEME_NAME}"/* "${THEME_DIR}/${THEME_NAME}"
    fi
}

function config_grub() {
    echo_primary 'Enabling grub menu'
    # remove default grub style if any
    echo_info "sudo sed -i '/GRUB_TIMEOUT_STYLE=/d' /etc/default/grub"
    sudo sed -i '/GRUB_TIMEOUT_STYLE=/d' /etc/default/grub

    echo_info "sudo bash -c \"echo 'GRUB_TIMEOUT_STYLE=\"menu\"' >> /etc/default/grub\""
    sudo bash -c "echo 'GRUB_TIMEOUT_STYLE=\"menu\"' >> /etc/default/grub"

    #--------------------------------------------------

    echo_primary 'Setting grub timeout to 3 seconds'
    # remove default timeout if any
    echo_info "sudo sed -i '/GRUB_TIMEOUT=/d' /etc/default/grub"
    sudo sed -i '/GRUB_TIMEOUT=/d' /etc/default/grub

    echo_info "sudo bash -c \"echo 'GRUB_TIMEOUT=\"3\"' >> /etc/default/grub\""
    sudo bash -c "echo 'GRUB_TIMEOUT=\"3\"' >> /etc/default/grub"

    #--------------------------------------------------

    echo_primary "Setting ${THEME_NAME} as default"
    # remove theme if any
    echo_info "sudo sed -i '/GRUB_THEME=/d' /etc/default/grub"
    sudo sed -i '/GRUB_THEME=/d' /etc/default/grub

    echo_info "sudo bash -c \"echo \"GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"\" >> /etc/default/grub\""
    sudo bash -c "echo \"GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"\" >> /etc/default/grub"
}

function update_grub() {
    # Update grub config
    echo_primary 'Updating grub config...'
    if [[ -x "$(command -v update-grub)" ]]; then
        echo_info 'sudo update-grub'
        sudo update-grub

    elif [[ -x "$(command -v grub-mkconfig)" ]]; then
        echo_info 'sudo grub-mkconfig -o /boot/grub/grub.cfg'
        sudo grub-mkconfig -o /boot/grub/grub.cfg

    elif [[ -x "$(command -v grub2-mkconfig)" ]]; then
        if [[ -x "$(command -v zypper)" ]]; then
            echo_info 'sudo grub2-mkconfig -o /boot/grub2/grub.cfg'
            sudo grub2-mkconfig -o /boot/grub2/grub.cfg

        elif [[ -x "$(command -v dnf)" ]]; then
            echo_info 'sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg'
            sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
        fi
    fi
}

function main() {
    splash 'TangoMan Theme Installer'

    install_theme

    config_grub
    update_grub
}

main
