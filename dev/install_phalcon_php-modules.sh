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

VALID_VERSIONS=(7.3 7.4 8.0 8.1)
DEFAULT_VERSION="$(php --version | grep -o -m1 "[0-9]\.[0-9]" | head -n1)"

if [ "$#" -gt 2 ]; then
    echo_error "too many arguments (${#})"
    echo_label 3 'usage'; echo_primary "$(basename "${0}") -o (optional) -v [version] -h (help)"
    exit 1
fi
OPTIND=0
while getopts :v:h OPTION; do
    case "${OPTION}" in
        v) VERSION="${OPTARG}";;
        h) echo_label 12 'description'; echo_primary 'Install php-modules'
            echo_label 12 'usage'; echo_primary "$(basename "${0}") -v [version] -h (help)"
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

alert_primary "Install Phalcon PHP modules for PHP${VERSION}"

if [ "${INSTALL}" = false ]; then
    echo_error "Cannot install modules for \"php${VERSION}\", invalid version"
    exit 1
fi

# install essential plugins for phalcon

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-calendar\""
sudo apt-get install --assume-yes "php${VERSION}-calendar"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-ctype\""
sudo apt-get install --assume-yes "php${VERSION}-ctype"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-curl\""
sudo apt-get install --assume-yes "php${VERSION}-curl"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-dom\""
sudo apt-get install --assume-yes "php${VERSION}-dom"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-exif\""
sudo apt-get install --assume-yes "php${VERSION}-exif"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-ffi\""
sudo apt-get install --assume-yes "php${VERSION}-ffi"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-fileinfo\""
sudo apt-get install --assume-yes "php${VERSION}-fileinfo"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-ftp\""
sudo apt-get install --assume-yes "php${VERSION}-ftp"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-gettext\""
sudo apt-get install --assume-yes "php${VERSION}-gettext"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-iconv\""
sudo apt-get install --assume-yes "php${VERSION}-iconv"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-igbinary\""
sudo apt-get install --assume-yes "php${VERSION}-igbinary"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-json\""
sudo apt-get install --assume-yes "php${VERSION}-json"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-mbstring\""
sudo apt-get install --assume-yes "php${VERSION}-mbstring"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-opcache\""
sudo apt-get install --assume-yes "php${VERSION}-opcache"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-pdo\""
sudo apt-get install --assume-yes "php${VERSION}-pdo"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-pdo_pgsql\""
sudo apt-get install --assume-yes "php${VERSION}-pdo_pgsql"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-pgsql\""
sudo apt-get install --assume-yes "php${VERSION}-pgsql"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-phalcon\""
sudo apt-get install --assume-yes "php${VERSION}-phalcon"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-phar\""
sudo apt-get install --assume-yes "php${VERSION}-phar"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-posix\""
sudo apt-get install --assume-yes "php${VERSION}-posix"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-psr\""
sudo apt-get install --assume-yes "php${VERSION}-psr"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-readline\""
sudo apt-get install --assume-yes "php${VERSION}-readline"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-redis\""
sudo apt-get install --assume-yes "php${VERSION}-redis"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-shmop\""
sudo apt-get install --assume-yes "php${VERSION}-shmop"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-simplexml\""
sudo apt-get install --assume-yes "php${VERSION}-simplexml"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-sockets\""
sudo apt-get install --assume-yes "php${VERSION}-sockets"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-sysvmsg\""
sudo apt-get install --assume-yes "php${VERSION}-sysvmsg"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-sysvsem\""
sudo apt-get install --assume-yes "php${VERSION}-sysvsem"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-sysvshm\""
sudo apt-get install --assume-yes "php${VERSION}-sysvshm"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-tokenizer\""
sudo apt-get install --assume-yes "php${VERSION}-tokenizer"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-wddx\""
sudo apt-get install --assume-yes "php${VERSION}-wddx"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-xdebug\""
sudo apt-get install --assume-yes "php${VERSION}-xdebug"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-xml\""
sudo apt-get install --assume-yes "php${VERSION}-xml"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-xmlreader\""
sudo apt-get install --assume-yes "php${VERSION}-xmlreader"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-xmlwriter\""
sudo apt-get install --assume-yes "php${VERSION}-xmlwriter"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-xsl\""
sudo apt-get install --assume-yes "php${VERSION}-xsl"

echo_info "sudo apt-get install --assume-yes \"php${VERSION}-zip\""
sudo apt-get install --assume-yes "php${VERSION}-zip"
