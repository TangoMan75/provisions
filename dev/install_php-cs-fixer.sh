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
# * PHP CS Fixer
# *
# * @link https://cs.symfony.com
# * @category dev
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

VERSION=3

alert_primary 'Install php-cs-fixer'

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

# download with wget
echo_info "wget -q https://cs.symfony.com/download/php-cs-fixer-v${VERSION}.phar"
wget -q https://cs.symfony.com/download/php-cs-fixer-v${VERSION}.phar

# install php-cs-fixer globally
echo_info "sudo mv -fv php-cs-fixer-v${VERSION}.phar /usr/local/bin/php-cs-fixer"
sudo mv -fv php-cs-fixer-v${VERSION}.phar /usr/local/bin/php-cs-fixer

# fix permissions
echo_info 'sudo chmod uga+x /usr/local/bin/php-cs-fixer'
sudo chmod uga+x /usr/local/bin/php-cs-fixer

echo_info 'sync'
sync

