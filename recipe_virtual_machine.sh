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

# gufw: firewall
./network/install_gufw.sh
# openssh-server: ssh server
./servers/install_openssh-server.sh
# gparted: partition manager
./system/install_gparted.sh
# p7zip-full: archive manager
./utils/install_p7zip-full.sh

#/**
# * config
# */
./system/config_keyboard.sh

#/**
# * recipe dev essentials
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

# essentials
./dev/install_git.sh
./dev/install_jq.sh

# extra devtools
./dev/install_github-cli.sh
./dev/install_mkcert.sh
./dev/install_shellcheck.sh

# containers
./devops/install_docker.io.sh
./devops/install_docker-compose.sh

# network
./network/config_known_ssh_hosts.sh
./network/install_awscli.sh
./network/install_nmap.sh

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

#/**
# * recipe dev php
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

./dev/install_php.sh
./dev/config_php.sh
./dev/install_php-modules.sh

# ide
./ide/config_jetbrains_gitignore.sh

# php / symfony
./dev/install_composer.sh
./dev/install_php-cs-fixer.sh
./dev/install_symfony-cli.sh

#/**
# * recipe extra
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

./security/install_protonvpn.sh
./security/install_torbrowser.sh

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
