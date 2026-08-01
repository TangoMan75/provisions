#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## symfony flex
##
## @category dev
## @link     https://github.com/symfony/flex

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install Symfony Flex'
_echo_warning 'Requires user interaction'

if [ ! -x "$(command -v composer)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires composer\n"
    exit 1
fi

# add symfony/flex to composer allow-plugins config
_echo_info 'composer global config --no-plugins allow-plugins.symfony/flex true\n'
composer global config --no-plugins allow-plugins.symfony/flex true

# install symfony flex globally to speed up download of composer packages (parallelized prefetching)
# --prefer-dist: This flag tells Composer to prefer installing the package from a pre-built distribution file (.phar or similar) if available. This can be faster than downloading the source code and compiling it.
# --no-progress: This flag suppresses the progress bar that Composer normally shows during installation.
# --classmap-authoritative: This flag tells Composer to trust the classmap file provided by the package instead of generating its own. This can be helpful if the package has specific requirements for how its classes are loaded.
_echo_info "composer global require 'symfony/flex' --prefer-dist --classmap-authoritative\n"
composer global require 'symfony/flex' --prefer-dist --classmap-authoritative

_echo_info 'composer clear-cache\n'
composer clear-cache
