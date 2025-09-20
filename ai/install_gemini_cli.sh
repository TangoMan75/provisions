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

PROJECT=gemini-cli

#--------------------------------------------------

if [ ! -x "$(command -v npx)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires npx, try: 'sudo apt-get install -y npx'\n"
    exit 1
fi

#--------------------------------------------------

alert_primary "Install ${PROJECT}"

#--------------------------------------------------

echo_info 'npx -y https://github.com/google-gemini/gemini-cli\n'
npx -y https://github.com/google-gemini/gemini-cli

