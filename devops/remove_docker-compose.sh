#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * remove docker-compose
# *
# * @category devops
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_danger 'Remove docker-compose'

echo_info 'sudo rm -f /usr/bin/docker-compose\n'
sudo rm -f /usr/bin/docker-compose

echo_info 'sudo rm -f ~/.docker/cli-plugins/docker-compose\n'
sudo rm -f ~/.docker/cli-plugins/docker-compose

