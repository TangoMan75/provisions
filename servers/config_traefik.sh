#!/bin/bash

#/**
# * config traefik
# *
# * @category servers
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

CONFIG_DIR="${BASEDIR}/../config"

# config traefik
echo_info "sudo cp -Rfv ${CONFIG_DIR}/etc/traefik/ /etc/traefik/"
sudo cp -Rfv ${CONFIG_DIR}/etc/traefik/ /etc/traefik/

