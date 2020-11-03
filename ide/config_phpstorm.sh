#!/bin/bash

#/**
# * config phpstorm
# *
# * @category ide
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

CONFIG_DIR="${BASEDIR}/../config"

PHPSTORM_VERSION='2020.2'

# config phpstorm
echo_info "cp -Rfv ${CONFIG_DIR}/home/.config/JetBrains/PhpStorm${PHPSTORM_VERSION}/ ~/.config/JetBrains/"
cp -Rfv ${CONFIG_DIR}/home/.config/JetBrains/PhpStorm${PHPSTORM_VERSION}/ ~/.config/JetBrains/

