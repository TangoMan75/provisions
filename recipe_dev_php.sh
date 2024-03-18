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

./update.sh
./upgrade.sh

./dev/install_php.sh
./dev/config_php.sh

./dev/install_php-modules.sh
./dev/config_php-xdebug.sh install

# ide
./ide/config_phpstorm.sh
./ide/install_phpstorm.sh
./ide/config_jetbrains_gitignore.sh

# php / symfony
./dev/install_composer.sh
./dev/install_php-cs-fixer.sh
./dev/install_symfony-cli.sh
