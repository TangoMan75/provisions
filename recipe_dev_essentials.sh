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

UPDATE=true
OPTIND=0
while getopts :nh OPTION; do
    case "${OPTION}" in
        n) UPDATE=false;;
        h) echo_warning "$(basename "${0}")";
            echo_label 14 '  description:'; echo_primary 'Recipe to provision essential dev environment'
            echo_label 14 '  usage:'; echo_primary "$(basename "${0}") -n (no-update) -h (help)"
            exit 0;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done
if [ "${UPDATE}" = true ]; then
    ./update.sh
    ./upgrade.sh
fi

# git
./dev/install_git.sh
./dev/config_git.sh

# github
./dev/install_github-cli.sh

# ide
./ide/config_visualstudiocode.sh
./ide/install_visualstudiocode.sh
./ide/install_vim.sh

# containers
./devops/install_docker-compose.sh
./devops/install_docker.io.sh

# network
./network/config_known_ssh_hosts.sh
./network/install_filezilla.sh
