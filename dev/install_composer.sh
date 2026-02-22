#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## composer
## php dependency manager
##
## ```
## sudo composer self-update
## ```
## @category dev
## @link     https://getcomposer.org/doc

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install composer'

if [ ! -x "$(command -v php)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires php, try: 'sudo apt-get install -y php'\n"
    exit 1
fi

# download latest stable composer.phar
_echo_info "php -r \"copy('https://getcomposer.org/composer-stable.phar', 'composer.phar');\"\n"
php -r "copy('https://getcomposer.org/composer-stable.phar', 'composer.phar');"

# install composer globally
_echo_info 'sudo mv -fv composer.phar /usr/local/bin/composer\n'
sudo mv -fv composer.phar /usr/local/bin/composer

# set executable permissions
_echo_info 'sudo chmod uga+x /usr/local/bin/composer\n'
sudo chmod uga+x /usr/local/bin/composer

_echo_info 'sync\n'
sync

_echo_info 'composer clear-cache\n'
composer clear-cache
