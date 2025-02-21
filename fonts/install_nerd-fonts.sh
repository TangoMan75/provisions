#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install nerd-fonts
##
## Clicking the "install" button on ".ttf" file copies it to "~/.local/share/fonts/" folder.
##
## @category fonts
## @license  MIT
## @link     https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS NF Regular.ttf
## @link     https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/S/Regular/MesloLGSNerdFontMono-Regular.ttf
## @link     https://github.com/ryanoasis/nerd-fonts

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

SOURCE="${CURDIR}/nerd-fonts"
DESTINATION=${HOME}/.local/share/fonts/

echo_info "mkdir -p \"${DESTINATION}\"\n"
mkdir -p "${DESTINATION}"

echo_info "cp \"${SOURCE}/MesloLGSNerdFont-BoldItalic.ttf\" \"${DESTINATION}/MesloLGSNerdFont-BoldItalic.ttf\"\n"
cp "${SOURCE}/MesloLGSNerdFont-BoldItalic.ttf" "${DESTINATION}/MesloLGSNerdFont-BoldItalic.ttf"

echo_info "cp \"${SOURCE}/MesloLGSNerdFont-Bold.ttf\" \"${DESTINATION}/MesloLGSNerdFont-Bold.ttf\"\n"
cp "${SOURCE}/MesloLGSNerdFont-Bold.ttf" "${DESTINATION}/MesloLGSNerdFont-Bold.ttf"

echo_info "cp \"${SOURCE}/MesloLGSNerdFont-Italic.ttf\" \"${DESTINATION}/MesloLGSNerdFont-Italic.ttf\"\n"
cp "${SOURCE}/MesloLGSNerdFont-Italic.ttf" "${DESTINATION}/MesloLGSNerdFont-Italic.ttf"

echo_info "cp \"${SOURCE}/MesloLGSNerdFont-Regular.ttf\" \"${DESTINATION}/MesloLGSNerdFont-Regular.ttf\"\n"
cp "${SOURCE}/MesloLGSNerdFont-Regular.ttf" "${DESTINATION}/MesloLGSNerdFont-Regular.ttf"

echo_info "cp \"${SOURCE}/MesloLGSNerdFontMono-Regular.ttf\" \"${DESTINATION}/MesloLGSNerdFontMono-Regular.ttf\"\n"
cp "${SOURCE}/MesloLGSNerdFontMono-Regular.ttf" "${DESTINATION}/MesloLGSNerdFontMono-Regular.ttf"

echo_info 'fc-cache -vf\n'
fc-cache -vf

