#!/bin/bash

#/**
# * rclone
# *
# * @category system
# * @link     https://rclone.org
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

{
    if [ ! -x "$(command -v curl)" ]; then
        # install rclone (via curl)
        echo_info 'curl https://rclone.org/install.sh | sudo bash'
        curl https://rclone.org/install.sh | sudo bash
    else
        # install rclone (via wget)
        echo_info 'wget https://rclone.org/install.sh && sudo bash install.sh'
        wget https://rclone.org/install.sh && sudo bash install.sh
    fi
} || {
    echo_error 'download failed'
    exit 1
}

echo_info 'sudo apt-get install --assume-yes rclone'
sudo apt-get install --assume-yes rclone
