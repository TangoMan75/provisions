#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install_zeroclaw
##
## Install ZeroClaw - Fast, small, autonomous AI assistant infrastructure
##
## ```
## # config can be found here
## ~/.zeroclaw
##
## # biniary can be found here
## ~/.cargo/bin/zeroclaw
##
## # start onboarding
## zeroclaw onboard --interactive
## ```
##
## @category ai
## @link     https://github.com/zeroclaw-labs/zeroclaw
## @link     https://zeroclawlabs.ai

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=zeroclaw
AUTHOR=zeroclaw-labs
REPOSITORY=${AUTHOR}/${APP_NAME}
DESTINATION="${HOME}/.local/share/${APP_NAME}"
BINARY_DESTINATION="${HOME}/.local/bin/${APP_NAME}"

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(git cargo)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

# clone project
_echo_info "git clone --depth 1 \"https://github.com/${REPOSITORY}\" \"${DESTINATION}\"\n"
git clone --depth 1 "https://github.com/${REPOSITORY}" "${DESTINATION}"

#--------------------------------------------------

(
    _echo_info "cd \"${DESTINATION}\" || exit\n"
    cd "${DESTINATION}" || exit

    _echo_info 'cargo build --features whatsapp-web --release\n'
    cargo build --features whatsapp-web --release

    _echo_info "cp \"./target/release/${APP_NAME}\" \"${BINARY_DESTINATION}\"\n"
    cp "./target/release/${APP_NAME}" "${BINARY_DESTINATION}"
)
