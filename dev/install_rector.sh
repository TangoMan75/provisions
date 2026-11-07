#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## rector
##
## Rector will be installed into `~/.config/composer/vendor/bin` directory.
## Execute rector with the following command:
## ```
## ~/.config/composer/vendor/bin/rector process <source_folder> --dry-run
## or
## rector process <source_folder> --dry-run
## ```
##
## To update rector:
## ```
## composer global update rector/rector
## ```
##
## @category dev
## @link     https://github.com/rectorphp/rector
## @link     https://getrector.com/documentation

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install Rector'

if [ ! -x "$(command -v composer)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires composer\n"
    exit 1
fi

# install rector globally
# --prefer-dist: This flag tells Composer to prefer installing the package from a pre-built distribution file (.phar or similar) if available. This can be faster than downloading the source code and compiling it.
# --no-progress: This flag suppresses the progress bar that Composer normally shows during installation.
# --classmap-authoritative: This flag tells Composer to trust the classmap file provided by the package instead of generating its own. This can be helpful if the package has specific requirements for how its classes are loaded.
_echo_info 'composer global require 'rector/rector' --quiet --prefer-dist --classmap-authoritative\n'
composer global require 'rector/rector' --quiet --prefer-dist --classmap-authoritative

_echo_info "sudo ln -sf \"${HOME}/.config/composer/vendor/bin/rector\" /usr/bin/rector\n"
sudo ln -sf "${HOME}/.config/composer/vendor/bin/rector" /usr/bin/rector

_echo_info 'composer clear-cache\n'
composer clear-cache
