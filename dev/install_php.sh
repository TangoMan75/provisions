#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * php
# * php language
# *
# * @category dev
# * @link     http://www.ansoncheunghk.info/article/8-essential-checks-securing-php
# * @link     https://www.php.net/supported-versions.php
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

VALID_VERSIONS=(7.3 7.4 8.0)
VERSION=8.0

if [ "$#" -gt 2 ]; then
    echo_error "too many arguments (${#})"
    echo_label 3 'usage'; echo_primary "$(basename "${0}") -v [version] -h (help)"
    exit 1
fi
OPTIND=0
while getopts :v:h OPTION; do
    case "${OPTION}" in
        v) VERSION="${OPTARG}";;
        h) echo_label 12 'description'; echo_primary 'Install php'
            echo_label 12 'usage'; echo_primary "$(basename "${0}") -v [version] -h (help)"
            exit 0;;
        :) echo_error "\"${OPTARG}\" requires value"
            exit 1;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done
for VALID_VERSION in "${VALID_VERSIONS[@]}"; do
    if [ "${VERSION}" = "${VALID_VERSION}" ]; then
        INSTALL=true
    fi
done
if [ "${INSTALL}" != true ]; then
    echo_error "\"$(basename "${0}")\" invalid version \"${VERSION}\""
    exit 1
fi

echo_info 'sudo add-apt-repository --yes ppa:ondrej/php'
sudo add-apt-repository --yes ppa:ondrej/php

echo_info 'sudo apt-get update'
sudo apt-get update

# note: following modules are installed by default (even with --no-install-recommends)
# "phpx.x-pdo" is included in "phpx.x-common"
# libapache2-mod-phpx.x
# php-common
# phpx.x
# phpx.x-calendar
# phpx.x-cli
# phpx.x-ctype
# phpx.x-exif
# phpx.x-ffi
# phpx.x-fileinfo
# phpx.x-ftp
# phpx.x-gettext
# phpx.x-iconv
# phpx.x-json
# phpx.x-opcache
# phpx.x-pdo
# phpx.x-phar
# phpx.x-posix
# phpx.x-readline
# phpx.x-shmop
# phpx.x-sockets
# phpx.x-sysvmsg
# phpx.x-sysvsem
# phpx.x-sysvshm
# phpx.x-tokenizer

echo_info "sudo apt-get install --assume-yes --no-install-recommends \"php${VERSION}\""
sudo apt-get install --assume-yes --no-install-recommends "php${VERSION}"

echo_info "sudo apt-get install --assume-yes --no-install-recommends \"php${VERSION}-fpm\""
sudo apt-get install --assume-yes --no-install-recommends "php${VERSION}-fpm"

