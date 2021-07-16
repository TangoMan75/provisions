#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * docker-compose
# *
# * @category devops
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install docker-compose'

if [ ! -x "$(command -v curl)" ]; then
    echo_error "\"$(basename "${0}")\" requires curl, try: 'sudo apt-get install -y curl'"
    exit 1
fi

echo_info "sudo curl -L \"https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)\" -o /usr/bin/docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose

# fix permissions
echo_info 'sudo chmod uga+x /usr/bin/docker-compose'
sudo chmod uga+x /usr/bin/docker-compose

echo_info 'sync'
sync

