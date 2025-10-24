#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## gemini-cli
##
## @category ai
## @link     https://github.com/google-gemini/gemini-cli

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=gemini-cli
#--------------------------------------------------

alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

# Check for required dependencies
for dep in node npm; do
    if ! command -v "${dep}" >/dev/null 2>&1; then
        echo_danger "error: '${dep}' is required but not installed"
        echo_info "You can install it with: sudo apt-get install -y ${dep}\n"
        exit 1
    fi
done

#--------------------------------------------------

echo_info 'sudo npm install -g @google/gemini-cli\n'
sudo npm install -g @google/gemini-cli

