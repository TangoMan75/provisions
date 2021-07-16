#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

##/**
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

#/**
# * recipe dev essentials
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

# essentials
./dev/install_git.sh

# containers
./devops/install_docker.io.sh
./devops/install_docker-compose.sh

# ide
./ide/config_sublime-text.sh
./ide/install_sublime-text.sh
./ide/install_vim.sh

# network
./network/config_known_ssh_hosts.sh
./network/install_insomnia.sh
./network/install_sqlitebrowser.sh

#/**
# * recipe dev bash
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

# essentials
./dev/install_jq.sh

# extra devtools
./dev/install_shellcheck.sh

#/**
# * recipe dev extra
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

# extra devtools
./dev/install_github-cli.sh
./dev/install_mkcert.sh

# network
./network/install_awscli.sh
./network/install_filezilla.sh
./network/install_nmap.sh
./network/install_remmina.sh
./network/install_zenmap.sh

#/**
# * recipe dev javascript
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

./dev/install_nodejs.sh

# javascript esssentials
./dev/install_npm.sh
./dev/install_yarn.sh

./dev/install_node-sass.sh
./dev/install_vue-cli.sh

# ide
./ide/install_visualstudiocode.sh

#/**
# * recipe dev php
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

./dev/install_php.sh
./dev/config_php.sh

./dev/install_php-modules.sh
./dev/config_php-xdebug.sh

# ide
./ide/config_phpstorm.sh
./ide/install_phpstorm.sh
./ide/config_jetbrains_gitignore.sh

# php / symfony
./dev/install_composer.sh
./dev/install_php-cs-fixer.sh
./dev/install_symfony-cli.sh

#/**
# * recipe dev python
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

# ides
./ide/config_pycharm-community.sh
./ide/install_pycharm-community.sh

#/**
# * recipe extra
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

./graphics/install_flameshot.sh
./graphics/install_gimp.sh
./graphics/install_inkscape.sh

./multimedia/install_obs-studio.sh

./productivity/install_dropbox.sh

./security/install_protonvpn.sh
./security/install_torbrowser.sh
# diodon: clipboard manager; I hate it. But some of you seem to like it, so...
./system/install_diodon.sh

./themes/install_bootloader_theme.sh

# network
./network/install_x11vnc.sh

# system
./system/install_zsh.sh

./fonts/install_fonts-powerline.sh

./themes/install_ohmyzsh.sh

./themes/install_tangoman-theme.sh

./system/install_bash_aliases.sh

./system/config_zsh.sh

./clean.sh
