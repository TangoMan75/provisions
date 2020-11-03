#!/bin/bash

#/**
# * php-modules
# * php extensions
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

CONFIG='false'
OPTIONAL='false'
VERSION=7.3

OPTIND=0
while getopts :cov:h OPTION; do
    case "${OPTION}" in
        c) CONFIG='true';;
        o) OPTIONAL='true';;
        v) VERSION="${OPTARG}";;
        h) echo_label 'description'; echo_primary 'Install php-modules'
            echo_label 'usage'; echo_primary "${0} -c (config) -o (optional) -v [version] -h (help)"
            exit 0;;
        :) echo_error "\"${OPTARG}\" requires value"
            exit 1;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done

# check valid version
INSTALL='false'
for VALID_VERSION in 5.6 7.0 7.1 7.2 7.3; do
    if [ "${VERSION}" = "${VALID_VERSION}" ]; then
        INSTALL='true'
    fi
done

if [ "${INSTALL}" = 'false' ]; then
    echo_error "Cannot install modules for \"php${VERSION}\", invalid version"
    exit 1
fi

# install php + essential plugins + symfony
echo_info "sudo apt-get install --assume-yes php${VERSION}-curl"
sudo apt-get install --assume-yes php${VERSION}-curl

echo_info "sudo apt-get install --assume-yes php${VERSION}-gd"
sudo apt-get install --assume-yes php${VERSION}-gd

echo_info "sudo apt-get install --assume-yes php${VERSION}-intl"
sudo apt-get install --assume-yes php${VERSION}-intl

echo_info "sudo apt-get install --assume-yes php${VERSION}-mbstring"
sudo apt-get install --assume-yes php${VERSION}-mbstring

echo_info "sudo apt-get install --assume-yes php${VERSION}-mysql"
sudo apt-get install --assume-yes php${VERSION}-mysql

echo_info "sudo apt-get install --assume-yes php${VERSION}-sqlite3"
sudo apt-get install --assume-yes php${VERSION}-sqlite3

echo_info "sudo apt-get install --assume-yes php${VERSION}-xml"
sudo apt-get install --assume-yes php${VERSION}-xml

echo_info "sudo apt-get install --assume-yes php${VERSION}-zip"
sudo apt-get install --assume-yes php${VERSION}-zip

# optional
if [ "${OPTIONAL}" = 'true' ]; then
    echo_info "sudo apt-get install --assume-yes php${VERSION}-apcu"
    sudo apt-get install --assume-yes php${VERSION}-apcu

    echo_info "sudo apt-get install --assume-yes php${VERSION}-cgi"
    sudo apt-get install --assume-yes php${VERSION}-cgi

    echo_info "sudo apt-get install --assume-yes php${VERSION}-dev"
    sudo apt-get install --assume-yes php${VERSION}-dev

    echo_info "sudo apt-get install --assume-yes php${VERSION}-geoip"
    sudo apt-get install --assume-yes php${VERSION}-geoip

    echo_info "sudo apt-get install --assume-yes php${VERSION}-gmp"
    sudo apt-get install --assume-yes php${VERSION}-gmp

    echo_info "sudo apt-get install --assume-yes php${VERSION}-mcrypt"
    sudo apt-get install --assume-yes php${VERSION}-mcrypt

    echo_info "sudo apt-get install --assume-yes php${VERSION}-memcache"
    sudo apt-get install --assume-yes php${VERSION}-memcache

    echo_info "sudo apt-get install --assume-yes php${VERSION}-memcached"
    sudo apt-get install --assume-yes php${VERSION}-memcached

    echo_info "sudo apt-get install --assume-yes php${VERSION}-msgpack"
    sudo apt-get install --assume-yes php${VERSION}-msgpack

    echo_info "sudo apt-get install --assume-yes php${VERSION}-pgsql"
    sudo apt-get install --assume-yes php${VERSION}-pgsql

    echo_info "sudo apt-get install --assume-yes php${VERSION}-redis"
    sudo apt-get install --assume-yes php${VERSION}-redis
fi

# enable extensions
if [ -f /etc/php/${VERSION}/cli/php.ini ] && [ "${CONFIG}" = 'true' ]; then
    echo_info "sudo sed -i -E s/\"^;extension=curl$\"/\"extension=curl\"/g /etc/php/${VERSION}/cli/php.ini"
    sudo sed -i -E s/"^;extension=curl$"/"extension=curl"/g /etc/php/${VERSION}/cli/php.ini

    echo_info "sudo sed -i -E s/\"^;extension=gd2$\"/\"extension=gd2\"/g /etc/php/${VERSION}/cli/php.ini"
    sudo sed -i -E s/"^;extension=gd2$"/"extension=gd2"/g /etc/php/${VERSION}/cli/php.ini

    echo_info "sudo sed -i -E s/\"^;extension=pdo_mysql$\"/\"extension=pdo_mysql\"/g /etc/php/${VERSION}/cli/php.ini"
    sudo sed -i -E s/"^;extension=pdo_mysql$"/"extension=pdo_mysql"/g /etc/php/${VERSION}/cli/php.ini

    echo_info "sudo sed -i -E s/\"^;extension=pdo_sqlite$\"/\"extension=pdo_sqlite\"/g /etc/php/${VERSION}/cli/php.ini"
    sudo sed -i -E s/"^;extension=pdo_sqlite$"/"extension=pdo_sqlite"/g /etc/php/${VERSION}/cli/php.ini
fi

# restart php-fpm service
echo_info "sudo systemctl restart php${VERSION}-fpm"
sudo systemctl restart php${VERSION}-fpm

# list installed modules
echo_info 'php -m'
php -m
