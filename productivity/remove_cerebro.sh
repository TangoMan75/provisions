#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## cerebro
##
## @category productivity
## @link     https://cerebroapp.com

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_danger 'Remove cerebro'

_echo_info 'rm -rf ~/.cerebro\n'
rm -rf ~/.cerebro

_echo_info 'rm ~/.local/share/applications/appimagekit-cerebro.desktop\n'
rm ~/.local/share/applications/appimagekit-cerebro.desktop

