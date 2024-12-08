#!/bin/bash

#/*
# * This file is part of TangoMan Bash Tools package.
# *
# * Copyright (c) 2023 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * TangoMan Colors Demo
# *
# * A demo to test colors
# *
# * @author  "Matthias Morin" <mat@tangoman.io>
# * @link    https://github.com/TangoMan75/tools
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/colors.sh"

function demo_echo() {
    echo_primary   'This is primary text'   2 24; echo 'primary'
    echo_secondary 'This is secondary text' 2 24; echo 'secondary'
    echo_success   'This is a success'      2 24; echo 'success'
    echo_danger    'This is a danger'       2 24; echo 'danger'
    echo_warning   'This is a warning'      2 24; echo 'warning'
    echo_info      'This is an info'        2 24; echo 'info'
    echo_light     'This is light'          2 24; echo 'light'
    echo_dark      'This is dark'           2 24; echo 'dark'
    echo
}

function demo_alert() {
    alert_primary   'This is a primary alert'
    alert_secondary 'This is a secondary alert'
    alert_success   'This is a success alert'
    alert_danger    'This is a danger alert'
    alert_warning   'This is a warning alert'
    alert_info      'This is a info alert'
    alert_light     'This is a light alert'
    alert_dark      'This is a dark alert'
}

demo_echo
demo_alert

