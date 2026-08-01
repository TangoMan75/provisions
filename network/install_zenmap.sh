#!/bin/bash

#/*
## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
#
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## zenmap
## nmap network scanner graphic interface
##
## @link     https://nmap.org/download.html
## @link     https://github.com/nmap/nmap
## @category network

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

REQUIRED_COMMANDS=(unzip python3 pipx)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

_alert_primary 'Install zenmap'

#--------------------------------------------------

SYSTEM_PACKAGES=(libcairo2-dev libgirepository-2.0-dev libgirepository1.0-dev python3-gi python3-gi-cairo gir1.2-gtk-3.0)
MISSING_PACKAGES=()
for pkg in "${SYSTEM_PACKAGES[@]}"; do
    if ! dpkg -s "${pkg}" &> /dev/null 2>&1; then
        MISSING_PACKAGES+=("${pkg}")
    fi
done

if [ ${#MISSING_PACKAGES[@]} -gt 0 ]; then
    _echo_warning "Installing missing system dependencies: ${MISSING_PACKAGES[*]}\n"
    _echo_info "sudo apt-get update && sudo apt-get install -y ${MISSING_PACKAGES[*]}\n"
    sudo apt-get update && sudo apt-get install -y "${MISSING_PACKAGES[@]}"
fi

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
_echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

ARCHIVE='master.zip'
URL='https://github.com/nmap/nmap/archive/refs/heads/master.zip'

#--------------------------------------------------

_echo_warning 'Downloading file to temporary directory\n'

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -Lf \"${URL}\" -o \"${TEMP_DIR}/${ARCHIVE}\"\n"
    curl -Lf "${URL}" -o "${TEMP_DIR}/${ARCHIVE}"

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -q \"${URL}\" -O \"${TEMP_DIR}/${ARCHIVE}\"\n"
    wget -q "${URL}" -O "${TEMP_DIR}/${ARCHIVE}"
fi

#--------------------------------------------------

if [ ! -s "${TEMP_DIR}/${ARCHIVE}" ] || head -n 1 "${TEMP_DIR}/${ARCHIVE}" | grep -q "<!DOCTYPE html>"; then
    _echo_danger "error: Downloaded file is invalid or not found.\n"
    rm -rf "${TEMP_DIR}"
    exit 1
fi

#--------------------------------------------------

_echo_warning "Extract \"${ARCHIVE}\"\n"

_echo_info "unzip \"${TEMP_DIR}/${ARCHIVE}\" -d \"${TEMP_DIR}\"\n"
unzip "${TEMP_DIR}/${ARCHIVE}" -d "${TEMP_DIR}"

#--------------------------------------------------

if [ ! -d "${TEMP_DIR}/nmap-master/zenmap" ]; then
    _echo_danger "error: zenmap directory not found in archive\n"
    rm -rf "${TEMP_DIR}"
    exit 1
fi

#--------------------------------------------------

_echo_info "cd \"${TEMP_DIR}/nmap-master/zenmap\" && pipx install --system .\n"
cd "${TEMP_DIR}/nmap-master/zenmap" && pipx install --system .

#--------------------------------------------------

_echo_warning "Creating symlink to make zenmap available system-wide\n"
PIPX_BIN_DIR="$(pipx list | grep -A1 'package zenmap' | grep -oP 'bin_dir\s+\K[^\s]+' || echo "${HOME}/.local/share/pipx/venvs/zenmap/bin")"
sudo ln -sf "${PIPX_BIN_DIR}/zenmap" /usr/bin/zenmap

#--------------------------------------------------

rm -rf "${TEMP_DIR}"

#--------------------------------------------------

if command -v zenmap &> /dev/null; then
    _echo_success "zenmap installed successfully\n"
else
    _echo_warning "zenmap command not found, you may need to restart your shell\n"
fi
