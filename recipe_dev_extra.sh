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
# * recipe dev extra
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

./update.sh
./upgrade.sh

# extra devtools
./dev/install_github-cli.sh
./dev/install_mkcert.sh

# network
./network/install_awscli.sh
./network/install_filezilla.sh
./network/install_nmap.sh
./network/install_remmina.sh
./network/install_zenmap.sh

./clean.sh
