#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## claude-code
##
## @category ai
## @link     https://www.claude.com

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=claude-code

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

alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

echo_info 'sudo npm install -g @anthropic-ai/claude-code\n'
sudo npm install -g @anthropic-ai/claude-code

