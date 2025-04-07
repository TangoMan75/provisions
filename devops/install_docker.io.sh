#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install docker.io
## container environments
##
## @category devops

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install docker.io'

echo_info 'sudo apt-get install --assume-yes docker.io\n'
sudo apt-get install --assume-yes docker.io

# add current user to docker group
echo_info "sudo usermod -a -G docker \"${USER}\"\n"
sudo usermod -a -G docker "${USER}"

echo_warning 'You will need to log out and log back in current user to use docker'
