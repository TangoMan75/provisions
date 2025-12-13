#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## config pycharm
##
## @category ide

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

CONFIG_DIR="${CURDIR}/../config"

DEFAULT_VERSION=2023.3

if [ "$#" -gt 2 ]; then
    echo_danger "error: too many arguments (${#})\n" 2
    echo_success 'usage:' 2 7; echo_primary "$(basename "${0}") -v [version] -d (development) -p (production) -h (help)\n"
    exit 1
fi
OPTIND=0
while getopts :v:h OPTION; do
    case "${OPTION}" in
        v) VERSION="${OPTARG}";;
        h) echo_success 'description:' 2 14; echo_primary 'Config PyCharmCE\n'
            echo_success 'usage:' 2 14; echo_primary "${0} -v [version] -h (help)\n"
            exit 0;;
        :) echo_danger "error: \"${OPTARG}\" requires value\n" 2
            exit 1;;
        \?) echo_danger "error: invalid option \"${OPTARG}\"\n" 2
            exit 1;;
    esac
done

if [ -z "${VERSION}" ]; then
    VERSION="${DEFAULT_VERSION}"
fi

alert_secondary "Config PyCharmCE${VERSION}"

echo_info 'mkdir -p ~/.config/JetBrains\n'
mkdir -p ~/.config/JetBrains

# remove previous config
echo_info "rm -rf ~/.config/JetBrains/PyCharmCE*\n"
rm -rf ~/.config/JetBrains/PyCharmCE*

# config pycharm
echo_info "cp -Rfv \"${CONFIG_DIR}/home/.config/JetBrains/PyCharmCE/\" \"${HOME}/.config/JetBrains/PyCharmCE${VERSION}\"\n"
cp -Rfv "${CONFIG_DIR}/home/.config/JetBrains/PyCharmCE/" "${HOME}/.config/JetBrains/PyCharmCE${VERSION}"
