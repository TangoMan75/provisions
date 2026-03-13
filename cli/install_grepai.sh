#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install_grepai
##
## AI-powered grep replacement that uses LLMs to search and replace code semantically.
##
## ```
## grepai init            # Initialize in your project
## grepai watch           # Start indexing daemon
## grepai search "query"  # Search with natural language
## ```
##
## @category cli
## @link     https://github.com/yoanbernabeu/grepai
## @link     https://www.youtube.com/watch?v=XE0MLWf2M1Y

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=grepai
AUTHOR=yoanbernabeu
REPOSITORY=${AUTHOR}/${APP_NAME}

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -fsSL https://raw.githubusercontent.com/${REPOSITORY}/main/install.sh | sh\n"
    curl -fsSL https://raw.githubusercontent.com/${REPOSITORY}/main/install.sh | sh

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -qO- https://raw.githubusercontent.com/${REPOSITORY}/main/install.sh | sh\n"
    wget -qO- https://raw.githubusercontent.com/${REPOSITORY}/main/install.sh | sh

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi
