#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## msgvault
##
## Local-first, open-source archive for email, chat, meetings, calendars,
## and contacts. Keep your history on your own hardware, find messages and
## files, and connect the addresses and handles that belong to the same
## person. Use the browser, terminal, CLI, HTTP API, or an AI assistant
## through MCP.
##
## Get started:
##   `msgvault init-db``
##   `msgvault add-account you@gmail.com``
##   `msgvault sync-full you@gmail.com --limit 100``
##   `msgvault tui``
##
## @category communication
## @link     https://msgvault.io
## @link     https://github.com/kenn-io/msgvault

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=msgvault

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -fsSL https://msgvault.io/install.sh | bash\n"
    curl -fsSL https://msgvault.io/install.sh | bash

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -qO- https://msgvault.io/install.sh | bash\n"
    wget -qO- https://msgvault.io/install.sh | bash

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi
