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
# * php-modules
# * php extensions
# *
# * @category dev
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install PHP modules'

OPTIONAL=false
VALID_VERSIONS=(7.3 7.4 8.0 8.1 8.2)
DEFAULT_VERSION="$(php --version | grep -o -m1 "[0-9]\.[0-9]" | head -n1)"

if [ "$#" -gt 2 ]; then
    echo_error "too many arguments (${#})"
    echo_label 3 'usage'; echo_primary "$(basename "${0}") -o (install optional modules) -v [version] -h (help)"
    exit 1
fi
OPTIND=0
while getopts :ov:h OPTION; do
    case "${OPTION}" in
        o) OPTIONAL=true;;
        v) VERSION="${OPTARG}";;
        h) echo_label 12 'description'; echo_primary 'Install php-modules'
            echo_label 12 'usage'; echo_primary "$(basename "${0}") -o (install optional modules) -v [version] -h (help)"
            exit 0;;
        :) echo_error "\"${OPTARG}\" requires value"
            exit 1;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done

if [ -z "${VERSION}" ]; then
    VERSION="${DEFAULT_VERSION}"
fi
# check valid version
INSTALL=false
for VALID_VERSION in "${VALID_VERSIONS[@]}"; do
    if [ "${VERSION}" = "${VALID_VERSION}" ]; then
        INSTALL=true
    fi
done

alert_secondary "TangoMan Install Modules for PHP${VERSION}"

if [ "${INSTALL}" != true ]; then
    echo_error "Cannot install modules for \"php${VERSION}\", invalid version"
    exit 1
fi

# install essential plugins + symfony
echo_info "sudo apt-get install --assume-yes \"php${VERSION}-apcu\""
sudo apt-get install --assume-yes "php${VERSION}-apcu"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-curl\""
sudo apt-get install --assume-yes "php${VERSION}-curl"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-gd\""
sudo apt-get install --assume-yes "php${VERSION}-gd"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-intl\""
sudo apt-get install --assume-yes "php${VERSION}-intl"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-mbstring\""
sudo apt-get install --assume-yes "php${VERSION}-mbstring"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-memcache\""
sudo apt-get install --assume-yes "php${VERSION}-memcache"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-memcached\""
sudo apt-get install --assume-yes "php${VERSION}-memcached"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-mysql\""
sudo apt-get install --assume-yes "php${VERSION}-mysql"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-opcache\""
sudo apt-get install --assume-yes "php${VERSION}-opcache"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-pgsql\""
sudo apt-get install --assume-yes "php${VERSION}-pgsql"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-sqlite3\""
sudo apt-get install --assume-yes "php${VERSION}-sqlite3"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-xdebug\""
sudo apt-get install --assume-yes "php${VERSION}-xdebug"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-xml\""
sudo apt-get install --assume-yes "php${VERSION}-xml"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-zip\""
sudo apt-get install --assume-yes "php${VERSION}-zip"

# optional
if [ "${OPTIONAL}" = true ]; then
    echo_info "sudo apt-get install --assume-yes \"php${VERSION}-amqp\""
    sudo apt-get install --assume-yes "php${VERSION}-amqp"

    echo_info "sudo apt-get install --assume-yes \"php${VERSION}-cgi\""
    sudo apt-get install --assume-yes "php${VERSION}-cgi"

    echo_info "sudo apt-get install --assume-yes \"php${VERSION}-dev\""
    sudo apt-get install --assume-yes "php${VERSION}-dev"

    echo_info "sudo apt-get install --assume-yes \"php${VERSION}-exif\""
    sudo apt-get install --assume-yes "php${VERSION}-exif"

    echo_info "sudo apt-get install --assume-yes \"php${VERSION}-fileinfo\""
    sudo apt-get install --assume-yes "php${VERSION}-fileinfo"

    echo_info "sudo apt-get install --assume-yes \"php${VERSION}-geoip\""
    sudo apt-get install --assume-yes "php${VERSION}-geoip"

    echo_info "sudo apt-get install --assume-yes \"php${VERSION}-gmp\""
    sudo apt-get install --assume-yes "php${VERSION}-gmp"

    echo_info "sudo apt-get install --assume-yes \"php${VERSION}-imagick\""
    sudo apt-get install --assume-yes "php${VERSION}-imagick"

    echo_info "sudo apt-get install --assume-yes \"php${VERSION}-ldap\""
    sudo apt-get install --assume-yes "php${VERSION}-ldap"

    echo_info "sudo apt-get install --assume-yes \"php${VERSION}-mcrypt\""
    sudo apt-get install --assume-yes "php${VERSION}-mcrypt"

    echo_info "sudo apt-get install --assume-yes \"php${VERSION}-mongodb\""
    sudo apt-get install --assume-yes "php${VERSION}-mongodb"

    echo_info "sudo apt-get install --assume-yes \"php${VERSION}-msgpack\""
    sudo apt-get install --assume-yes "php${VERSION}-msgpack"

    echo_info "sudo apt-get install --assume-yes \"php${VERSION}-pdo_mysql\""
    sudo apt-get install --assume-yes "php${VERSION}-pdo_mysql"

    echo_info "sudo apt-get install --assume-yes \"php${VERSION}-pdo_pgsql\""
    sudo apt-get install --assume-yes "php${VERSION}-pdo_pgsql"

    echo_info "sudo apt-get install --assume-yes \"php${VERSION}-redis\""
    sudo apt-get install --assume-yes "php${VERSION}-redis"

    echo_info "sudo apt-get install --assume-yes \"php${VERSION}-soap\""
    sudo apt-get install --assume-yes "php${VERSION}-soap"

    echo_info "sudo apt-get install --assume-yes \"php${VERSION}-xsl\""
    sudo apt-get install --assume-yes "php${VERSION}-xsl"
fi

