#!/bin/bash

#/**
# * remove rclone
# *
# * @category network
# * @link     https://rclone.org
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

{
    echo_info 'sudo apt-get remove --assume-yes --autoremove rclone'
    sudo apt-get remove --assume-yes --autoremove rclone
} || {
    # binary
    echo_info 'sudo rm -f /usr/bin/rclone'
    sudo rm -f /usr/bin/rclone

    # manuals
    echo_info 'sudo rm -f /usr/local/share/man/man1/rclone.1'
    sudo rm -f /usr/local/share/man/man1/rclone.1
}
