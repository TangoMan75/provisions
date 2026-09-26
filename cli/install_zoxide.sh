#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## zoxide
##
## A smarter cd, written in Rust, that learns your most-used directories
##
## @category cli
## @link     https://crates.io/crates/zoxide
## @link     https://github.com/ajeetdsouza/zoxide

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(curl)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

APP_NAME="zoxide"
INSTALL_URL="https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh"

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

# The official zoxide install script downloads the latest release for the
# current platform, installs the binary, and sets up the man pages.
# PREFIX controls the install location; we target /usr to place the binary
# in /usr/bin. The script is run as root so it can write system-wide.
_echo_info "curl -sSfL \"${INSTALL_URL}\" | sudo PREFIX=/usr sh\n"

if ! sudo env PREFIX=/usr sh -c "curl -sSfL \"${INSTALL_URL}\" | sh"; then
    _echo_danger "error: Failed to install ${APP_NAME}.\n"
    exit 1
fi

#--------------------------------------------------

_echo_warning 'Hook zoxide into your shell (required)\n'
_echo_info 'Add the following line to your ~/.bashrc or ~/.zshrc:\n\n'
_echo_primary "  eval \"\$(zoxide init bash)\"\n"
_echo_info "For zsh use: eval \"\$(zoxide init zsh)\"\n"
_echo_info "For fish use: zoxide init fish | source\n"
_echo_info 'You can then use "z" to jump to directories.\n'
