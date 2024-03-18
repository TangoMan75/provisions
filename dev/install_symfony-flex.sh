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
# * symfony flex
# *
# * @category dev
# * @link     https://github.com/symfony/flex
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install Symfony Flex'
echo_warning 'Requires user interaction'

if [ ! -x "$(command -v composer)" ]; then
    echo_error "\"$(basename "${0}")\" requires composer"
    exit 1
fi

# install symfony flex globally to speed up download of composer packages (parallelized prefetching)
echo_info "composer global require 'symfony/flex' --prefer-dist --no-progress --no-suggest --classmap-authoritative"
composer global require 'symfony/flex' --prefer-dist --no-progress --no-suggest --classmap-authoritative

echo_info 'composer clear-cache'
composer clear-cache
