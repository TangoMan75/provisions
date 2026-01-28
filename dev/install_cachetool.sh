#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## cachetool
## php opcache manager
##
## @category dev

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v php)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires php, try: 'sudo apt-get install -y php'\n"
    exit 1
fi

echo_info 'php -r "copy('http://gordalina.github.io/cachetool/downloads/cachetool.phar', 'cachetool.phar');"\n'
php -r "copy('http://gordalina.github.io/cachetool/downloads/cachetool.phar', 'cachetool.phar');"

# install cachetool globally
echo_info 'sudo mv -fv cachetool.phar /usr/local/bin/cachetool\n'
sudo mv -fv cachetool.phar /usr/local/bin/cachetool

# make cachetool executable
echo_info 'sudo chmod uga+x /usr/local/bin/cachetool\n'
sudo chmod uga+x /usr/local/bin/cachetool

echo_info 'sync\n'
sync

