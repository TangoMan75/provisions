#!/bin/bash

#/**
# * config org_gnome
# *
# * @category kali
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

CONFIG_DIR="${BASEDIR}/../config"

if [ "$(`lsb_release -is` 2>/dev/null)" = 'Kali' ]; then
    echo_info "dconf load /org/gnome/ < $CONFIG_DIR/kali/dconf/org_gnome.conf"
    dconf load /org/gnome/ < $CONFIG_DIR/kali/dconf/org_gnome.conf
else
    echo_error 'wrong system version'
fi
