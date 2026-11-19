#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## geckodriver
##
## Install geckodriver
##
## Alternatively run: "composer require --dev dbrekelmans/bdi && vendor/bin/bdi detect drivers"
##
## @category browser

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

VERSION=0.28.0

_alert_primary "Install geckdriver v${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

_echo_info "wget -q https://github.com/mozilla/geckodriver/releases/download/v${VERSION}/geckodriver-v${VERSION}-linux64.tar.gz\n"
wget -q https://github.com/mozilla/geckodriver/releases/download/v${VERSION}/geckodriver-v${VERSION}-linux64.tar.gz

_echo_info "sudo tar -zxf geckodriver-v${VERSION}-linux64.tar.gz -C /usr/bin\n"
sudo tar -zxf geckodriver-v${VERSION}-linux64.tar.gz -C /usr/bin

_echo_info "rm geckodriver-v${VERSION}-linux64.tar.gz\n"
rm geckodriver-v${VERSION}-linux64.tar.gz

