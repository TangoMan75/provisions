#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## php
## php language
##
## @category dev
## @link     https://www.php.net/supported-versions.php

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

_alert_primary 'Install PHP'

#--------------------------------------------------

# note: following modules are installed by default (even with --no-install-recommends)
# `ls /usr/lib/php/20250925`
# calendar.so
# ctype.so
# exif.so
# ffi.so
# fileinfo.so
# ftp.so
# gettext.so
# iconv.so
# pdo.so
# phar.so
# posix.so
# readline.so
# shmop.so
# sockets.so
# sysvmsg.so
# sysvsem.so
# sysvshm.so
# tokenizer.so

_echo_info 'sudo apt-get install --assume-yes --no-install-recommends php\n'
sudo apt-get install --assume-yes --no-install-recommends php

_echo_info 'sudo apt-get install --assume-yes --no-install-recommends php-cli\n'
sudo apt-get install --assume-yes --no-install-recommends php-cli

_echo_info 'sudo apt-get install --assume-yes --no-install-recommends php-fpm\n'
sudo apt-get install --assume-yes --no-install-recommends php-fpm

