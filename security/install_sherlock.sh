#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## sherlock
##
## Hunt down social media accounts by username across social networks
##
## ```
## cd ~/.sherlock/sherlock
## python3 sherlock.py --csv --print-all USERNAMES
## ```
##
## @category security
## @link     https://github.com/sherlock-project/sherlock
## @link     https://sherlockproject.xyz

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install sherlock'

#--------------------------------------------------

if [ ! -x "$(command -v pipx)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires pipx, try: 'sudo apt-get install -y pipx'\n"
    exit 1
fi

#--------------------------------------------------

_echo_info 'pipx install sherlock-project\n'
pipx install sherlock-project
