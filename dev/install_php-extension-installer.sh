#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## php-modules
##
## /!\ this is meant to install php extensions in containers only
##
## @category dev
## @link     https://github.com/mlocati/docker-php-extension-installer

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

_echo_info 'wget -qO install-php-extensions https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions\n'
wget -qO install-php-extensions https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions

# install installer globally
_echo_info 'sudo mv -fv install-php-extensions /usr/local/bin/install-php-extensions\n'
sudo mv -fv install-php-extensions /usr/local/bin/install-php-extensions

# set executable permissions
_echo_info 'sudo chmod uga+x /usr/local/bin/install-php-extensions\n'
sudo chmod uga+x /usr/local/bin/install-php-extensions

_echo_info 'sync\n'
sync
