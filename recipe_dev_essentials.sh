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
# * recipe dev essentials
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

./update.sh
./upgrade.sh

# git
./dev/install_git.sh
./dev/config_git.sh

# containers
./devops/install_docker-compose.sh
./devops/install_docker.io.sh

# github
./dev/install_github-cli.sh

# ide
./ide/config_sublime-text.sh
./ide/install_sublime-text.sh
./ide/config_visualstudiocode.sh
./ide/install_visualstudiocode.sh
./ide/install_vim.sh

# network
./network/config_known_ssh_hosts.sh
./network/install_dbeaver-ce.sh
./network/install_insomnia.sh
