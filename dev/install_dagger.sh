#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## dagger
## portable and programmable CI/CD engine
##
## @category dev
## @link     https://github.com/dagger/dagger

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v curl)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires curl, try: 'sudo apt-get install -y curl'\n"
    exit 1
fi

#--------------------------------------------------

APP_NAME=dagger
DESTINATION="${HOME}/.local/bin"
DEFAULT_VERSION=0.19.11

#--------------------------------------------------

_alert_primary "Install ${APP_NAME} v${DEFAULT_VERSION}"

#--------------------------------------------------

if [ ! -d "${DESTINATION}" ]; then
    _echo_warning 'Create destination folder\n'

    _echo_info "mkdir -p \"${DESTINATION}\"\n"
    mkdir -p "${DESTINATION}"
fi

#--------------------------------------------------

_echo_warning 'Download and install dagger\n'

_echo_info "curl -fsSL https://dl.dagger.io/dagger/install.sh | DAGGER_VERSION=${DEFAULT_VERSION} BIN_DIR=${DESTINATION} sh\n"
curl -fsSL https://dl.dagger.io/dagger/install.sh | DAGGER_VERSION="${DEFAULT_VERSION}" BIN_DIR="${DESTINATION}" sh

#--------------------------------------------------

_echo_warning "Setting executable permissions for ${APP_NAME}\n"

_echo_info "chmod uga+x \"${DESTINATION}/${APP_NAME}\"\n"
chmod uga+x "${DESTINATION}/${APP_NAME}"

#--------------------------------------------------

# Check PATH and provide instructions
if ! echo "${PATH}" | grep -q "${DESTINATION}"; then
    _echo_warning "${DESTINATION} is not in your PATH\n"
    _echo_info "To use ${APP_NAME} from anywhere, add the following to your shell profile:\n\n"
    _echo_warning "  export PATH=\"\$PATH:${DESTINATION}\"\n\n"
    _echo_info 'For bash, add it to ~/.bashrc or ~/.bash_profile\n'
    _echo_info 'For zsh, add it to ~/.zshrc\n'
    _echo_info "For fish, run: fish_add_path ${DESTINATION}\n"
fi
