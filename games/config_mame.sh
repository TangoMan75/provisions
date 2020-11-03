#!/bin/bash

#/**
# * config mame
# *
# * @category games
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

CONFIG_DIR="${BASEDIR}/../config"

echo_info "sudo cp -Rfv ${CONFIG_DIR}/home/.mame ~"
sudo cp -Rfv ${CONFIG_DIR}/home/.mame ~
