#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## php-modules
## php extensions
##
## @category dev
## @link     https://www.php.net/supported-versions.php

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install PHP modules'

OPTIONAL=false
VALID_VERSIONS=(7.3 7.4 8.0 8.1 8.2 8.3 8.4)
DEFAULT_VERSION="$(php --version | grep -o -m1 "[0-9]\.[0-9]" | head -n1)"

if [ "$#" -gt 2 ]; then
    _echo_danger "error: too many arguments (${#})\n" 2
    _echo_success 'usage:' 2 7; _echo_primary "$(basename "${0}") -o (install optional modules) -v [version] -h (help)\n"
    exit 1
fi
OPTIND=0
while getopts :ov:h OPTION; do
    case "${OPTION}" in
        o) OPTIONAL=true;;
        v) VERSION="${OPTARG}";;
        h) _echo_success 'description:' 2 14; _echo_primary 'Install php-modules\n'
            _echo_success 'usage:' 2 14; _echo_primary "$(basename "${0}") -o (install optional modules) -v [version] -h (help)\n"
            exit 0;;
        :) _echo_danger "error: \"${OPTARG}\" requires value\n" 2
            exit 1;;
        \?) _echo_danger "error: invalid option \"${OPTARG}\"\n" 2
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

_alert_secondary "TangoMan Install Modules for PHP${VERSION}"

if [ "${INSTALL}" != true ]; then
    _echo_danger "error: Cannot install modules for \"php${VERSION}\", invalid version\n" 2
    exit 1
fi

# install essential plugins + symfony
_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-apcu\"\n"
sudo apt-get install --assume-yes "php${VERSION}-apcu"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-curl\"\n"
sudo apt-get install --assume-yes "php${VERSION}-curl"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-gd\"\n"
sudo apt-get install --assume-yes "php${VERSION}-gd"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-intl\"\n"
sudo apt-get install --assume-yes "php${VERSION}-intl"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-mbstring\"\n"
sudo apt-get install --assume-yes "php${VERSION}-mbstring"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-memcache\"\n"
sudo apt-get install --assume-yes "php${VERSION}-memcache"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-memcached\"\n"
sudo apt-get install --assume-yes "php${VERSION}-memcached"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-mysql\"\n"
sudo apt-get install --assume-yes "php${VERSION}-mysql"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-opcache\"\n"
sudo apt-get install --assume-yes "php${VERSION}-opcache"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-pgsql\"\n"
sudo apt-get install --assume-yes "php${VERSION}-pgsql"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-sqlite3\"\n"
sudo apt-get install --assume-yes "php${VERSION}-sqlite3"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-xdebug\"\n"
sudo apt-get install --assume-yes "php${VERSION}-xdebug"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-xml\"\n"
sudo apt-get install --assume-yes "php${VERSION}-xml"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-zip\"\n"
sudo apt-get install --assume-yes "php${VERSION}-zip"

# optional
if [ "${OPTIONAL}" = true ]; then
    _echo_info "sudo apt-get install --assume-yes \"php${VERSION}-amqp\"\n"
    sudo apt-get install --assume-yes "php${VERSION}-amqp"

    _echo_info "sudo apt-get install --assume-yes \"php${VERSION}-cgi\"\n"
    sudo apt-get install --assume-yes "php${VERSION}-cgi"

    _echo_info "sudo apt-get install --assume-yes \"php${VERSION}-dev\"\n"
    sudo apt-get install --assume-yes "php${VERSION}-dev"

    _echo_info "sudo apt-get install --assume-yes \"php${VERSION}-exif\"\n"
    sudo apt-get install --assume-yes "php${VERSION}-exif"

    _echo_info "sudo apt-get install --assume-yes \"php${VERSION}-fileinfo\"\n"
    sudo apt-get install --assume-yes "php${VERSION}-fileinfo"

    _echo_info "sudo apt-get install --assume-yes \"php${VERSION}-geoip\"\n"
    sudo apt-get install --assume-yes "php${VERSION}-geoip"

    _echo_info "sudo apt-get install --assume-yes \"php${VERSION}-gmp\"\n"
    sudo apt-get install --assume-yes "php${VERSION}-gmp"

    _echo_info "sudo apt-get install --assume-yes \"php${VERSION}-imagick\"\n"
    sudo apt-get install --assume-yes "php${VERSION}-imagick"

    _echo_info "sudo apt-get install --assume-yes \"php${VERSION}-ldap\"\n"
    sudo apt-get install --assume-yes "php${VERSION}-ldap"

    _echo_info "sudo apt-get install --assume-yes \"php${VERSION}-mcrypt\"\n"
    sudo apt-get install --assume-yes "php${VERSION}-mcrypt"

    _echo_info "sudo apt-get install --assume-yes \"php${VERSION}-mongodb\"\n"
    sudo apt-get install --assume-yes "php${VERSION}-mongodb"

    _echo_info "sudo apt-get install --assume-yes \"php${VERSION}-msgpack\"\n"
    sudo apt-get install --assume-yes "php${VERSION}-msgpack"

    _echo_info "sudo apt-get install --assume-yes \"php${VERSION}-pdo_mysql\"\n"
    sudo apt-get install --assume-yes "php${VERSION}-pdo_mysql"

    _echo_info "sudo apt-get install --assume-yes \"php${VERSION}-pdo_pgsql\"\n"
    sudo apt-get install --assume-yes "php${VERSION}-pdo_pgsql"

    _echo_info "sudo apt-get install --assume-yes \"php${VERSION}-redis\"\n"
    sudo apt-get install --assume-yes "php${VERSION}-redis"

    _echo_info "sudo apt-get install --assume-yes \"php${VERSION}-soap\"\n"
    sudo apt-get install --assume-yes "php${VERSION}-soap"

    _echo_info "sudo apt-get install --assume-yes \"php${VERSION}-xsl\"\n"
    sudo apt-get install --assume-yes "php${VERSION}-xsl"
fi

