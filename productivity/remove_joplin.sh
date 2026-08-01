#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove joplin
##
## @category productivity

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# remove Joplin
_echo_info 'rm -rf ~/.joplin\n'
rm -rf ~/.joplin

# remove icon
_echo_info 'rm -f ~/.local/share/icons/hicolor/512x512/apps/joplin.png\n'
rm -f ~/.local/share/icons/hicolor/512x512/apps/joplin.png

_echo_info 'rm -f ~/.local/share/applications/appimagekit-joplin.desktop\n'
rm -f ~/.local/share/applications/appimagekit-joplin.desktop
