#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.

#/**
# * recipe dev python
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

./update.sh
./upgrade.sh

# ides
./ide/config_pycharm-community.sh
./ide/install_pycharm-community.sh
