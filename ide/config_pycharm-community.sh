#!/bin/bash

#/**
# * config pycharm-community
# *
# * @category ide
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

CONFIG_DIR="${BASEDIR}/../config"

PYCHARM_VERSION='2020.2'

# config pycharm-community
echo_info "cp -Rfv ${CONFIG_DIR}/home/.config/JetBrains/PyCharmCE${PYCHARM_VERSION}/ ~/.config/JetBrains/"
cp -Rfv ${CONFIG_DIR}/home/.config/JetBrains/PyCharmCE${PYCHARM_VERSION}/ ~/.config/JetBrains/

