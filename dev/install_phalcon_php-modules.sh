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

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

VALID_VERSIONS=(7.3 7.4 8.0 8.1)
DEFAULT_VERSION="$(php --version | grep -o -m1 "[0-9]\.[0-9]" | head -n1)"

if [ "$#" -gt 2 ]; then
    _echo_danger "error: too many arguments (${#})\n" 2
    _echo_success 'usage:' 2 7; _echo_primary "$(basename "${0}") -o (optional) -v [version] -h (help)\n"
    exit 1
fi
OPTIND=0
while getopts :v:h OPTION; do
    case "${OPTION}" in
        v) VERSION="${OPTARG}";;
        h) _echo_success 'description:' 2 14; _echo_primary 'Install php-modules\n'
            _echo_success 'usage:' 2 14; _echo_primary "$(basename "${0}") -v [version] -h (help)\n"
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

_alert_primary "Install Phalcon PHP modules for PHP${VERSION}"

if [ "${INSTALL}" = false ]; then
    _echo_danger "error: Cannot install modules for \"php${VERSION}\", invalid version\n" 2
    exit 1
fi

# install essential plugins for phalcon

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-calendar\"\n"
sudo apt-get install --assume-yes "php${VERSION}-calendar"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-ctype\"\n"
sudo apt-get install --assume-yes "php${VERSION}-ctype"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-curl\"\n"
sudo apt-get install --assume-yes "php${VERSION}-curl"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-dom\"\n"
sudo apt-get install --assume-yes "php${VERSION}-dom"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-exif\"\n"
sudo apt-get install --assume-yes "php${VERSION}-exif"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-ffi\"\n"
sudo apt-get install --assume-yes "php${VERSION}-ffi"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-fileinfo\"\n"
sudo apt-get install --assume-yes "php${VERSION}-fileinfo"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-ftp\"\n"
sudo apt-get install --assume-yes "php${VERSION}-ftp"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-gettext\"\n"
sudo apt-get install --assume-yes "php${VERSION}-gettext"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-iconv\"\n"
sudo apt-get install --assume-yes "php${VERSION}-iconv"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-igbinary\"\n"
sudo apt-get install --assume-yes "php${VERSION}-igbinary"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-json\"\n"
sudo apt-get install --assume-yes "php${VERSION}-json"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-mbstring\"\n"
sudo apt-get install --assume-yes "php${VERSION}-mbstring"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-opcache\"\n"
sudo apt-get install --assume-yes "php${VERSION}-opcache"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-pdo\"\n"
sudo apt-get install --assume-yes "php${VERSION}-pdo"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-pdo_pgsql\"\n"
sudo apt-get install --assume-yes "php${VERSION}-pdo_pgsql"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-pgsql\"\n"
sudo apt-get install --assume-yes "php${VERSION}-pgsql"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-phalcon\"\n"
sudo apt-get install --assume-yes "php${VERSION}-phalcon"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-phar\"\n"
sudo apt-get install --assume-yes "php${VERSION}-phar"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-posix\"\n"
sudo apt-get install --assume-yes "php${VERSION}-posix"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-psr\"\n"
sudo apt-get install --assume-yes "php${VERSION}-psr"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-readline\"\n"
sudo apt-get install --assume-yes "php${VERSION}-readline"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-redis\"\n"
sudo apt-get install --assume-yes "php${VERSION}-redis"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-shmop\"\n"
sudo apt-get install --assume-yes "php${VERSION}-shmop"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-simplexml\"\n"
sudo apt-get install --assume-yes "php${VERSION}-simplexml"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-sockets\"\n"
sudo apt-get install --assume-yes "php${VERSION}-sockets"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-sysvmsg\"\n"
sudo apt-get install --assume-yes "php${VERSION}-sysvmsg"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-sysvsem\"\n"
sudo apt-get install --assume-yes "php${VERSION}-sysvsem"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-sysvshm\"\n"
sudo apt-get install --assume-yes "php${VERSION}-sysvshm"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-tokenizer\"\n"
sudo apt-get install --assume-yes "php${VERSION}-tokenizer"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-wddx\"\n"
sudo apt-get install --assume-yes "php${VERSION}-wddx"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-xdebug\"\n"
sudo apt-get install --assume-yes "php${VERSION}-xdebug"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-xml\"\n"
sudo apt-get install --assume-yes "php${VERSION}-xml"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-xmlreader\"\n"
sudo apt-get install --assume-yes "php${VERSION}-xmlreader"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-xmlwriter\"\n"
sudo apt-get install --assume-yes "php${VERSION}-xmlwriter"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-xsl\"\n"
sudo apt-get install --assume-yes "php${VERSION}-xsl"

_echo_info "sudo apt-get install --assume-yes \"php${VERSION}-zip\"\n"
sudo apt-get install --assume-yes "php${VERSION}-zip"
