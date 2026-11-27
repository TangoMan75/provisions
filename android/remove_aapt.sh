#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove aapt
##
## Removes the Android Asset Packaging Tool (aapt and aapt2).
##
## @category android
## @link     https://developer.android.com/tools/aapt2

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=aapt

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

# both aapt and aapt2 are shipped by the same package
_echo_info "sudo apt-get remove -y \"${APP_NAME}\"\n"
sudo apt-get remove -y "${APP_NAME}"

#--------------------------------------------------

_echo_info 'sudo apt-get --assume-yes autoremove\n'
sudo apt-get --assume-yes autoremove
