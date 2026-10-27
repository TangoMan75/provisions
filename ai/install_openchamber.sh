#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "TangoMan" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install_openchamber
##
## Web interface for OpenCode
##
## ```bash
## opencode serve
## openchamber --ui-password 'toor' # Start server on port 3000
## openchamber --help
## ```
##
## @category ai
## @link     https://github.com/btriapitsyn/openchamber

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=openchamber
AUTHOR=btriapitsyn
REPOSITORY=${AUTHOR}/${APP_NAME}
UI_PASSWORD="$(tr -dc 'A-Za-z0-9!@#$%^&*()_+=' </dev/urandom | head -c 12)"

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -fsSL https://raw.githubusercontent.com/${REPOSITORY}/main/scripts/install.sh | bash -s -- --ui-password ${UI_PASSWORD}\n"
    curl -fsSL "https://raw.githubusercontent.com/${REPOSITORY}/main/scripts/install.sh" | bash -s -- --ui-password "${UI_PASSWORD}"

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -qO- https://raw.githubusercontent.com/${REPOSITORY}/main/scripts/install.sh | bash -s -- --ui-password ${UI_PASSWORD}\n"
    wget -qO- "https://raw.githubusercontent.com/${REPOSITORY}/main/scripts/install.sh" | bash -s -- --ui-password "${UI_PASSWORD}"

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi
