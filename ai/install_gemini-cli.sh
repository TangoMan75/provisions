#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## gemini-cli
##
## My configuration
## `~/.gemini/settings.json`
## ```json
## {
##   "context": {
##     "fileName": "AGENTS.md"
##   },
##   "mcpServers": {
##     "sharedAgents": {
##       "httpUrl": "https://mcp.context7.com/mcp"
##     }
##   },
##   "model": {
##     "name": "gemini-2.5-flash"
##   },
##   "security": {
##     "auth": {
##       "selectedType": "oauth-personal"
##     }
##   },
##   "ui": {
##     "theme": "GitHub"
##   }
## }
## ```
##
## ```bash
## #change default model
## export GEMINI_MODEL="gemini-2.5-flash"; gemini
## ```
##
## @category ai
## @link     https://github.com/google-gemini/gemini-cli
## @link     https://aistudio.google.com/api-keys

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=gemini-cli
AUTHOR=google
PACKAGE_NAME="@${AUTHOR}/${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v npm)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires npm\n"
    exit 1
fi

#--------------------------------------------------

_alert_primary "Install ${PACKAGE_NAME}"

#--------------------------------------------------

_echo_info "sudo npm install -g \"${PACKAGE_NAME}\"\n"
sudo npm install -g "${PACKAGE_NAME}"

#--------------------------------------------------

_echo_info 'gemini -v\n'
gemini -v

