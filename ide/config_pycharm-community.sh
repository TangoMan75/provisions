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
# * config pycharm
# *
# * @category ide
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

CONFIG_DIR="${CURDIR}/../config"

DEFAULT_VERSION=2023.3

if [ "$#" -gt 2 ]; then
    echo_error "too many arguments (${#})"
    echo_label 3 'usage'; echo_primary "$(basename "${0}") -v [version] -d (development) -p (production) -h (help)"
    exit 1
fi
OPTIND=0
while getopts :v:h OPTION; do
    case "${OPTION}" in
        v) VERSION="${OPTARG}";;
        h) echo_label 12 'description'; echo_primary 'Config PyCharmCE'
            echo_label 12 'usage'; echo_primary "${0} -v [version] -h (help)"
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

alert_secondary "Config PyCharmCE${VERSION}"

echo_info 'mkdir ~/.config/JetBrains'
mkdir ~/.config/JetBrains

# remove previous config
echo_info "rm -rf ~/.config/JetBrains/PyCharmCE*"
rm -rf ~/.config/JetBrains/PyCharmCE*

# config pycharm
echo_info "cp -Rfv \"${CONFIG_DIR}/home/.config/JetBrains/PyCharmCE/\" \"${HOME}/.config/JetBrains/PyCharmCE${VERSION}\""
cp -Rfv "${CONFIG_DIR}/home/.config/JetBrains/PyCharmCE/" "${HOME}/.config/JetBrains/PyCharmCE${VERSION}"
