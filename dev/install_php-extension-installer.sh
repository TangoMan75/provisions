#!/bin/bash

#/**
# * php-modules
# * php extensions
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'wget'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

# Install symfony PHP Core extensions dependencies (amqp gd intl pdo_mysql pdo_pgsql xsl zip)
# https://github.com/mlocati/docker-php-extension-installer

echo_info 'wget -qO install-php-extensions https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions'
wget -qO install-php-extensions https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions

# install installer globally
echo_info 'sudo mv install-php-extensions /usr/local/bin/install-php-extensions'
sudo mv install-php-extensions /usr/local/bin/install-php-extensions

# fix permissions
echo_info 'sudo chmod uga+x /usr/local/bin/install-php-extensions'
sudo chmod uga+x /usr/local/bin/install-php-extensions

echo_info 'sync'
sync

echo_info 'install-php-extensions amqp gd intl pdo_mysql pdo_pgsql xsl zip'
install-php-extensions amqp gd intl pdo_mysql pdo_pgsql xsl zip

