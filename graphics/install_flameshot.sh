#!/bin/bash

#/**
# * flameshot
# * better screenshot
# *
# * @category graphics
# * @link     https://github.com/flameshot-org/flameshot
# * @note     create a keyboard shortcut to `/usr/bin/flameshot gui`
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes flameshot'
sudo apt-get install --assume-yes flameshot
