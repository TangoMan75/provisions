#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## pulseaudio-equalizer
##
## Start qpaeq equilizer
## ```
## qpaeq
## ```
##
## @link     https://livingthelinuxlifestyle.wordpress.com/2018/08/13/how-to-install-pulseaudio-equalizer-in-ubuntu-and-linux-mint/
## @link     https://askubuntu.com/questions/980876/how-do-i-start-pulseaudio-equalizer
## @category multimedia

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_echo_info 'sudo apt-get install --assume-yes pulseaudio-equalizer\n'
sudo apt-get install --assume-yes pulseaudio-equalizer

# append configuration to /etc/pulse/default.pa
_echo_info 'echo -en "load-module module-equalizer-sink\nload-module module-dbus-protocol" | sudo tee -a /etc/pulse/default.pa\n'
echo -en "load-module module-equalizer-sink\nload-module module-dbus-protocol" | sudo tee -a /etc/pulse/default.pa

# restart Pulse Audio
_echo_info 'pulseaudio --kill && pulseaudio --start\n'
pulseaudio --kill && pulseaudio --start

