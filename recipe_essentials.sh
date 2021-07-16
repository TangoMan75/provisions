#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * recipe essentials
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

./update.sh
./upgrade.sh

#/**
# * system essentials
# * these will most likely be required
# */
./dev/install_python3-pip.sh
./network/install_curl.sh
./system/install_make.sh

#/**
# * essentials
# */

# chrome: browser
./browser/install_chrome.sh
# ferdi: communication tool
./communication/install_ferdi.sh
# vlc: music/video player
./multimedia/install_vlc.sh
# gufw: firewall
./network/install_gufw.sh
# libreoffice-calc: spread sheet editor
./office/install_libreoffice-calc.sh
# libreoffice-writer: rich text editor
./office/install_libreoffice-writer.sh
# gnome-clocks: alarm & world clock
./productivity/install_gnome-clocks.sh
# openssh-server: ssh server
./servers/install_openssh-server.sh
# gparted: partition manager
./system/install_gparted.sh
# stacer: system manager
./system/install_stacer.sh
# p7zip-full: archive manager
./utils/install_p7zip-full.sh

#/**
# * config
# */
./system/config_grub.sh
./system/config_keyboard.sh

# dconf-editor: gnome configuration manager
./system/install_dconf-editor.sh
./system/config_gnome_dconf.sh

./clean.sh

