#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# *

#/**
# * recipe dev javascript
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

./update.sh
./upgrade.sh

./dev/install_nodejs.sh

# javascript esssentials
./dev/install_npm.sh
./dev/install_yarn.sh

./dev/install_node-sass.sh
./dev/install_vue-cli.sh
