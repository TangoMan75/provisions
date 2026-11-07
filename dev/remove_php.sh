#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove php
##
## @category dev

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=php
PPA=ppa:ondrej/php

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_info 'sudo apt-get purge --assume-yes php-common\n'
sudo apt-get purge --assume-yes php-common

_echo_info 'sudo rm -rf /etc/php\n'
sudo rm -rf /etc/php

_echo_info 'sudo rm -rf /var/lib/php\n'
sudo rm -rf /var/lib/php

_echo_info 'sudo rm -rf /usr/lib/php\n'
sudo rm -rf /usr/lib/php

_echo_info 'sudo apt-get purge --assume-yes blackfire-php\n'
sudo apt-get purge --assume-yes blackfire-php

_echo_info 'sudo apt-get purge --assume-yes blackfire-agent\n'
sudo apt-get purge --assume-yes blackfire-agent

_echo_info 'sudo apt-get --assume-yes autoremove\n'
sudo apt-get --assume-yes autoremove

#--------------------------------------------------

if [ -n "${PPA}" ]; then
    _echo_info "sudo add-apt-repository --remove --yes \"${PPA}\"\n"
    sudo add-apt-repository --remove --yes "${PPA}"

    # add-apt-repository may leave the source file behind when the PPA has no
    # Release file for this release.
    for SOURCE in /etc/apt/sources.list.d/ondrej-ubuntu-php-*.sources /etc/apt/sources.list.d/ondrej-php-*.list; do
        if [ -f "${SOURCE}" ]; then
            _echo_info "sudo rm -f \"${SOURCE}\"\n"
            sudo rm -f "${SOURCE}"
        fi
    done

    _echo_info 'sudo apt-get update\n'
    sudo apt-get update
fi

