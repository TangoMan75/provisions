#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## PHP CS Fixer
##
## @link https://cs.symfony.com
## @category dev

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

VERSION=3

_alert_primary 'Install php-cs-fixer'

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

# download with wget
_echo_info "wget -q https://cs.symfony.com/download/php-cs-fixer-v${VERSION}.phar\n"
wget -q https://cs.symfony.com/download/php-cs-fixer-v${VERSION}.phar

# install php-cs-fixer globally
_echo_info "sudo mv -fv php-cs-fixer-v${VERSION}.phar /usr/local/bin/php-cs-fixer\n"
sudo mv -fv php-cs-fixer-v${VERSION}.phar /usr/local/bin/php-cs-fixer

# set executable permissions
_echo_info 'sudo chmod uga+x /usr/local/bin/php-cs-fixer\n'
sudo chmod uga+x /usr/local/bin/php-cs-fixer

_echo_info 'sync\n'
sync

