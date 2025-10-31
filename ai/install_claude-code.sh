#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## claude-code
##
## ```
## claude --context path/to/custom-instructions.md
## ```
##
## project-level override:
## `.claude/settings.json`
## ```json
## {
##   "context": "path/to/custom-instructions.md"
## }
## ```
##
## @category ai
## @link     https://www.claude.com
## @link     https://www.npmjs.com/package/@anthropic-ai/claude-code

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=claude-code
AUTHOR=anthropic-ai
PACKAGE_NAME="@${AUTHOR}/${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v npm)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires npm\n"
    exit 1
fi

#--------------------------------------------------

alert_primary "Install ${PACKAGE_NAME}"

#--------------------------------------------------

echo_info "sudo npm install -g ${PACKAGE_NAME}\n"
sudo npm install -g ${PACKAGE_NAME}

