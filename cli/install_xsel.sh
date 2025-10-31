#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## xsel
##
## pipe terminal stdin and stdout to clipboard
##
## ```
## # example
## echo 'foobar' | xsel --input --clipboard
## xsel --output --clipboard > foobar.txt
##
## # create aliases
## alias pbcopy='xsel --input --clipboard'
## alias pbpaste='xsel --output --clipboard'
## ```
##
## @category cli

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=xsel

#--------------------------------------------------

alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
sudo apt-get install --assume-yes "${APP_NAME}"

