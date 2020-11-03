#!/bin/bash

#/**
# * install essentials
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

## Initialise git submodules
if [ -f ./.gitmodules ] && [ ! -f ./tools/.git ]; then
    git submodule update --init --recursive
fi

./update.sh
./upgrade.sh

./gnome/install_dconf-editor.sh
./gnome/config_gnome_dconf.sh

./ide/install_sublime-text.sh
./ide/config_sublime-text.sh

./communication/install_station.sh
./ide/install_vim.sh
./multimedia/install_vlc.sh
./network/install_chrome.sh
./network/install_curl.sh
./office/install_libreoffice-calc.sh
./office/install_libreoffice-writer.sh
./productivity/install_dropbox.sh
./security/install_torbrowser.sh
./servers/install_openssh-server.sh
./system/config_keyboard.sh
./system/install_gparted.sh
./system/install_make.sh
./utils/install_p7zip-full.sh

./clean.sh
