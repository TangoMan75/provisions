#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove nerd-fonts
##
## @category fonts
## @license  MIT

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

alert_primary 'Remove nerd fonts'

FONTS_FOLDER=${HOME}/.local/share/fonts/

#--------------------------------------------------

echo_info "rm -f \"${FONTS_FOLDER}/MesloLGSNerdFonts-Bold.ttf\"\n"
rm -f "${FONTS_FOLDER}/MesloLGSNerdFonts-Bold.ttf"

echo_info "rm -f \"${FONTS_FOLDER}/MesloLGSNerdFonts-BoldItalic.ttf\"\n"
rm -f "${FONTS_FOLDER}/MesloLGSNerdFonts-BoldItalic.ttf"

echo_info "rm -f \"${FONTS_FOLDER}/MesloLGSNerdFonts-Italic.ttf\"\n"
rm -f "${FONTS_FOLDER}/MesloLGSNerdFonts-Italic.ttf"

echo_info "rm -f \"${FONTS_FOLDER}/MesloLGSNerdFonts-Regular.ttf\"\n"
rm -f "${FONTS_FOLDER}/MesloLGSNerdFonts-Regular.ttf"

echo_info "rm -f \"${FONTS_FOLDER}/MesloLGSNerdFontMono-Regular.ttf\"\n"
rm -f "${FONTS_FOLDER}/MesloLGSNerdFontMono-Regular.ttf"

#--------------------------------------------------

echo_info 'fc-cache -vf\n'
fc-cache -vf

