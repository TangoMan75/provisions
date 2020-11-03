#!/bin/bash

#/**
# * install server
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

## Initialise git submodules
if [ -f ./.gitmodules ] && [ ! -f ./tools/.git ]; then
    git submodule update --init --recursive
fi

./update.sh

./ide/install_vim.sh
./network/config_known_ssh_hosts.sh
./network/install_curl.sh
./system/install_make.sh

./devops/install_docker-compose.sh
./devops/install_docker.io.sh

./clean.sh
