#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * recipe tangoman
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

./recipe_essentials.sh

#/**
# * dev
# */

./ide/config_phpstorm.sh
./ide/install_phpstorm_eap.sh
./ide/config_jetbrains_gitignore.sh

./ide/config_visualstudiocode.sh
./ide/install_visualstudiocode.sh

./ide/install_vim.sh

./ide/install_ide-url-handler.sh

# php
./dev/install_php.sh
./dev/config_php.sh
./dev/install_composer.sh

# Javascript
./dev/install_nodejs.sh
./dev/install_npm.sh
./dev/install_yarn.sh

# containers
./devops/install_docker.io.sh
./devops/install_docker-compose.sh

# git
./dev/install_github-cli.sh

# network
./network/config_known_ssh_hosts.sh
./network/install_dbeaver-ce.sh
./network/install_insomnia.sh
./network/install_postman.sh
./security/install_openconnect.sh
./network/install_net-tools.sh
./network/install_filezilla.sh

# devops
./devops/install_k9s.sh
./devops/install_kubectl.sh

#/**
# * Cloud
# */

./devops/install_google-cloud-sdk.sh

#/**
# * Communication
# */

# slack
./communication/install_slack.sh
# ferdium: communication tool
./communication/install_ferdium.sh

#/**
# * productivity
# */

./productivity/install_dropbox.sh

#/**
# * bash
# */

./recipe_dev_bash.sh -n

#/**
# * config
# */

./drivers/install_blueman.sh
./themes/install_bootloader_theme.sh

# set samba password
./servers/config_samba.sh password

#/**
# * Oh my zsh
# */

./recipe_oh-my-zsh.sh -n

./clean.sh
