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
# * composer
# * php dependency manager
# *
# * @category dev
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

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

# fix permissions
echo_info 'sudo chmod uga+x /usr/local/bin/composer'
sudo chmod uga+x /usr/local/bin/composer

echo_info 'sync'
sync

# install symfony flex globally to speed up download of composer packages (parallelized prefetching)
echo_info "composer global require 'symfony/flex' --prefer-dist --no-progress --no-suggest --classmap-authoritative"
composer global require 'symfony/flex' --prefer-dist --no-progress --no-suggest --classmap-authoritative

echo_info 'composer clear-cache'
composer clear-cache

# update to latest unstable release
# echo_info 'composer self-update --preview'
# composer self-update --preview

