#!/bin/bash

#/**
# * cachetool
# * php opcache manager
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

if [ ! -x "$(command -v php)" ]; then
    echo_error 'cachetool requires php to install'
    exit 1
fi

echo_info 'php -r "copy('http://gordalina.github.io/cachetool/downloads/cachetool.phar', 'cachetool.phar');"'
php -r "copy('http://gordalina.github.io/cachetool/downloads/cachetool.phar', 'cachetool.phar');"

# install cachetool globally
echo_info 'sudo mv cachetool.phar /usr/local/bin/cachetool'
sudo mv cachetool.phar /usr/local/bin/cachetool

# make cachetool executable
echo_info 'sudo chmod uga+x /usr/local/bin/cachetool'
sudo chmod uga+x /usr/local/bin/cachetool

echo_info 'sync'
sync

