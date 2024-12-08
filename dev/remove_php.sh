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
# * remove php
# *
# * @category dev
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo apt-get purge --assume-yes php-common\n'
sudo apt-get purge --assume-yes php-common

echo_info 'sudo rm -rf /etc/php\n'
sudo rm -rf /etc/php

echo_info 'sudo rm -rf /var/lib/php\n'
sudo rm -rf /var/lib/php

echo_info 'sudo rm -rf /usr/lib/php\n'
sudo rm -rf /usr/lib/php

echo_info 'sudo apt-get purge --assume-yes blackfire-php\n'
sudo apt-get purge --assume-yes blackfire-php

echo_info 'sudo apt-get purge --assume-yes blackfire-agent\n'
sudo apt-get purge --assume-yes blackfire-agent

echo_info 'sudo apt-get --assume-yes autoremove\n'
sudo apt-get --assume-yes autoremove

