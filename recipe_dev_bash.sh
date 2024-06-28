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
# * recipe dev bash
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
            echo_label 14 '  description:'; echo_primary 'Recipe to provision bash dev environement'
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

# essentials
./dev/install_jq.sh
./dev/install_yq.sh

# extra devtools
./dev/install_shellcheck.sh
./system/install_tree.sh
./system/install_xsel.sh

