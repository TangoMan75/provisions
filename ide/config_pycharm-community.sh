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
# * config pycharm-community
# *
# * @category ide
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

CONFIG_DIR="${CURDIR}/../config"

VERSION='2021.2'

alert_secondary "Config PyCharmCE v${VERSION}"

echo_info 'mkdir ~/.config/JetBrains'
mkdir ~/.config/JetBrains

# config pycharm-community
echo_info "cp -Rfv \"${CONFIG_DIR}/home/.config/JetBrains/PyCharmCE${VERSION}/\" ~/.config/JetBrains/"
cp -Rfv "${CONFIG_DIR}/home/.config/JetBrains/PyCharmCE${VERSION}/" ~/.config/JetBrains/

