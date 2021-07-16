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
# * install php-xdebug
# * php debugger
# *
# * @category dev
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

function get_php_version() {
    # grep -o : only matching pattern
    # grep -m1 : stop after first match
    php --version | grep -o -m1 "[0-9]\.[0.9]"
}

function install_xdebug() {
    local VERSION
    VERSION="$(get_php_version)"

    echo_info "sudo apt-get install --assume-yes \"php${VERSION}-xdebug\""
    sudo apt-get install --assume-yes "php${VERSION}-xdebug"
}

install_xdebug

