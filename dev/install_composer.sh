#!/bin/bash

#/**
# * composer
# * php dependency manager
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'php'` == 'false' ]; then
    echo_error "composer requires php to install, try: 'sudo apt-get install -y php'"
    exit 1
fi

# download latest stable composer.phar
echo_info "php -r \"copy('https://getcomposer.org/composer-stable.phar', 'composer.phar');\""
php -r "copy('https://getcomposer.org/composer-stable.phar', 'composer.phar');"

# install composer globally
echo_info 'sudo mv composer.phar /usr/local/bin/composer'
sudo mv composer.phar /usr/local/bin/composer

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

