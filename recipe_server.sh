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
# * recipe server
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

./update.sh

# config
./network/config_known_ssh_hosts.sh

# ide
./ide/install_vim.sh

# essential
./dev/install_git.sh
./network/install_curl.sh
./system/install_make.sh

# containers
./devops/install_docker.io.sh
./devops/install_docker-compose.sh

./clean.sh
