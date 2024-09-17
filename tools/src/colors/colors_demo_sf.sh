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
. "${CURDIR}/colors_sf.sh"

PADDING=9

function demo_echo() {
    echo_primary   'This is primary text   (97m)'
    echo_secondary 'This is secondary text (94m)'
    echo_success   'This is a success      (32m)'
    echo_danger    'This is a danger       (31m)'
    echo_warning   'This is a warning      (33m)'
    echo_info      'This is an info        (95m)'
    echo_light     'This is light          (47;90m)'
    echo_dark      'This is dark           (40;37m)'
    echo
    echo_label     "${PADDING}" 'label (32m):'; echo_primary 'This is a label'
    echo_error     'This is an error (31m)'
    echo
}

function demo_alert() {
    alert_primary   'This is a primary alert   (104;37m)'
    alert_secondary 'This is a secondary alert (45;37m)'
    alert_success   'This is a success alert   (42;30m)'
    alert_danger    'This is a danger alert    (41;37m)'
    alert_warning   'This is a warning alert   (43;30m)'
    alert_info      'This is a info alert      (44;37m)'
    alert_light     'This is a light alert     (47;90m)'
    alert_dark      'This is a dark alert      (40;37m)'
}

demo_echo
demo_alert

