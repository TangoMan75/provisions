#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove opencode-quota
##
## Remove OpenCode quota management CLI tool plugin
##
## @category ai
## @link     https://www.npmjs.com/package/@slkiser/opencode-quota
## @link     https://github.com/slkiser/opencode-quota

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=opencode-quota
AUTHOR=slkiser
PACKAGE_NAME="@${AUTHOR}/${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v npm)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires npm, try: 'sudo apt-get install -y npm'\n"
    exit 1
fi

#--------------------------------------------------

_alert_primary "Remove ${PACKAGE_NAME}"

#--------------------------------------------------

_echo_info 'rm ~/.config/opencode/opencode.jsonc\n'
rm ~/.config/opencode/opencode.jsonc

_echo_info 'rm ~/.config/opencode/tui.json\n'
rm ~/.config/opencode/tui.json

_echo_info 'rm -rf ~/.config/opencode/opencode-quota\n'
rm -rf ~/.config/opencode/opencode-quota

