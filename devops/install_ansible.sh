#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## ansible
##
## @category devops
## @link     https://docs.ansible.com

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# --------------------------------------------------

APP_NAME=ansible
PPA=ppa:ansible/ansible

alert_primary "Install ${APP_NAME}"

# --------------------------------------------------

if [ -n "${PPA}" ]; then
    echo_info "sudo add-apt-repository --yes \"${PPA}\"\n"
    sudo add-apt-repository --yes "${PPA}"

    echo_info 'sudo apt-get update\n'
    sudo apt-get update
fi

# --------------------------------------------------

echo_info 'sudo apt-get install --assume-yes software-properties-common\n'
sudo apt-get install --assume-yes software-properties-common

# --------------------------------------------------

echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
sudo apt-get install --assume-yes "${APP_NAME}"

