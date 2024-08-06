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
# * composer
# * php dependency manager
# *
# * @category dev
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install composer'

if [ ! -x "$(command -v php)" ]; then
    echo_error "\"$(basename "${0}")\" requires php, try: 'sudo apt-get install -y php'"
    exit 1
fi

# download latest stable composer.phar
echo_info "php -r \"copy('https://getcomposer.org/composer-stable.phar', 'composer.phar');\""
php -r "copy('https://getcomposer.org/composer-stable.phar', 'composer.phar');"

# install composer globally
echo_info 'sudo mv -fv composer.phar /usr/local/bin/composer'
sudo mv -fv composer.phar /usr/local/bin/composer

# set executable permissions
echo_info 'sudo chmod uga+x /usr/local/bin/composer'
sudo chmod uga+x /usr/local/bin/composer

echo_info 'sync'
sync

echo_info 'composer clear-cache'
composer clear-cache
