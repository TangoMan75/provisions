#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install_pdftk-java
##
## Install pdftk-java PDF toolkit
##
## NOTE: Ubuntu no longer ships the original C++ pdftk,
## but pdftk-java is a drop‑in replacement maintained by the same author.
##
## Remove pages from a PDF
## ```
## pdftk input.pdf cat 1-3 output out.pdf
## ```
##
## @category productivity
## @link     https://gitlab.com/pdftk/pdftk

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=pdftk-java

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

_echo_info 'sudo apt-get update\n'
sudo apt-get update

#--------------------------------------------------

_echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
sudo apt-get install --assume-yes "${APP_NAME}"
