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

./dev/install_nodejs.sh
./dev/install_php.sh
./network/install_curl.sh

./ide/config_phpstorm.sh
./ide/install_phpstorm.sh

./ide/config_pycharm-community.sh
./ide/install_pycharm-community.sh

#./ide/install_sublime-text.sh
#./ide/config_sublime-text.sh

./devops/install_docker.io.sh
./devops/install_docker-compose.sh

./dev/install_composer.sh
./dev/install_insomnia.sh
./dev/install_node-sass.sh
./dev/install_npm.sh
./dev/install_python3-pip.sh
./dev/install_yarn.sh
./ide/install_vim.sh
./network/config_known_ssh_hosts.sh
./network/install_gufw.sh
./network/install_sqlitebrowser.sh
./system/install_make.sh

./clean.sh
