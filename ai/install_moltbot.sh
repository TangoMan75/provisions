#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## moltbot
##
## AI-powered CLI tool for chat automation and agent management
##
## ```
## # Clawdbot configuration is stored under `~/.clawdbot`
## cd ~/.clawdbot/
## ```
##
## @category ai
## @link     https://molt.bot
## @link     https://github.com/moltbot/moltbot
## @link     https://clawdhub.com/skills

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

alert_primary 'Install moltbot'

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    echo_info "curl -LsSf https://molt.bot/install.sh | bash\n"
    curl -LsSf https://molt.bot/install.sh | bash

elif [ -x "$(command -v wget)" ]; then
    echo_info "wget -qO- https://molt.bot/install.sh | bash\n"
    wget -qO- https://molt.bot/install.sh | bash

else
    echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

