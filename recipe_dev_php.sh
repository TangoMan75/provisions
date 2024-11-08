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
# * recipe dev php
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
            echo_label 14 '  description:'; echo_primary 'Recipe to provision javascript php environement'
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

./dev/install_php.sh
./dev/config_php.sh

./dev/install_php-modules.sh
./dev/config_php-xdebug.sh install

# ide
./ide/config_phpstorm.sh
./ide/install_phpstorm.sh
./ide/config_jetbrains_gitignore.sh
./ide/install_ide-url-handler.sh

# php / symfony
./dev/install_composer.sh
# ./dev/install_php-cs-fixer.sh
./dev/install_rector.sh
# ./dev/install_symfony-cli.sh

