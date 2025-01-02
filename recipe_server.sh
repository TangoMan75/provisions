#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
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

UPDATE=true
OPTIND=0
while getopts :nh OPTION; do
    case "${OPTION}" in
        n) UPDATE=false;;
        h) echo_warning "$(basename "${0}")";
            echo_success 'description:' 2 14; echo_primary 'Recipe to provision server side environement\n'
            echo_success 'usage:' 2 14; echo_primary "$(basename "${0}") -n (no-update) -h (help)\n"
            exit 0;;
        \?) echo_danger "error: invalid option \"${OPTARG}\"\n"
            exit 1;;
    esac
done
if [ "${UPDATE}" = true ]; then
    ./update.sh
    ./upgrade.sh
fi

# config
./network/config_known_ssh_hosts.sh

# ide
./ide/install_vim.sh

# essential
./dev/install_git.sh
./network/install_curl.sh
./servers/install_apache2-utlis.sh
./system/install_make.sh

# containers
./devops/install_docker.io.sh
./devops/install_docker-compose.sh

