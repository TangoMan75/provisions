#!/bin/bash

#/*
# * This file is part of TangoMan Bash Tools package.
# *
# * Copyright (c) 2023 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

# https://github.com/pgrange/bash_unit
#
#     assert "test -e /tmp/the_file"
#     assert_fails "grep this /tmp/the_file" "should not write 'this' in /tmp/the_file"
#     assert_status_code 25 code
#     assert_equals "a string" "another string" "a string should be another string"
#     assert_not_equals "a string" "a string" "a string should be different from another string"
#     fake ps echo hello world

src_file="../src/colors/colors_sfd.sh"

# shellcheck source=/dev/null
. "${src_file}"

test_script_execution_should_return_expected_status_code() {
    assert_status_code 0 "${src_file}"
}

test_echo_primary_should_return_expected_string() {
    assert_status_code 127 "$(echo_primary foobar)"
    assert_equals "$(printf '\033[97m%b\033[0m' foobar)" "$(echo_primary foobar)"
}

test_echo_secondary_should_return_expected_string() {
    assert_status_code 127 "$(echo_secondary foobar)"
    assert_equals "$(printf '\033[94m%b\033[0m' foobar)" "$(echo_secondary foobar)"
}

test_echo_success_should_return_expected_string() {
    assert_status_code 127 "$(echo_success foobar)"
    assert_equals "$(printf '\033[32m%b\033[0m' foobar)" "$(echo_success foobar)"
}

test_echo_danger_should_return_expected_string() {
    assert_status_code 127 "$(echo_danger foobar)"
    assert_equals "$(printf '\033[31m%b\033[0m' foobar)" "$(echo_danger foobar)"
}

test_echo_warning_should_return_expected_string() {
    assert_status_code 127 "$(echo_warning foobar)"
    assert_equals "$(printf '\033[33m%b\033[0m' foobar)" "$(echo_warning foobar)"
}

test_echo_info_should_return_expected_string() {
    assert_status_code 127 "$(echo_info foobar)"
    assert_equals "$(printf '\033[95m%b\033[0m' foobar)" "$(echo_info foobar)"
}

test_echo_light_should_return_expected_string() {
    assert_status_code 127 "$(echo_light foobar)"
    assert_equals "$(printf '\033[47;90m%b\033[0m' foobar)" "$(echo_light foobar)"
}

test_echo_dark_should_return_expected_string() {
    assert_status_code 127 "$(echo_dark foobar)"
    assert_equals "$(printf '\033[40;37m%b\033[0m' foobar)" "$(echo_dark foobar)"
}

test_echo_label_should_return_expected_string() {
    assert_status_code 127 "$(echo_label 10 foobar)"
    assert_equals "$(printf '\033[32m%-10s \033[0m' foobar)" "$(echo_label 10 foobar)"
}

test_echo_label_without_padding_should_return_expected_string() {
    assert_status_code 127 "$(echo_label foobar)"
    assert_equals "$(printf '\033[32m%b \033[0m' foobar)" "$(echo_label foobar)"
}

test_echo_error_should_return_expected_string() {
    assert_status_code 127 "$(echo_error foobar)"
    assert_equals "$(printf '\033[31merror: %b\033[0m' foobar)" "$(echo_error foobar)"
}

test_alert_primary_should_return_expected_string() {
    assert_status_code 127 "$(alert_primary)"
    assert_equals "$(printf "\033[0m\n\033[104;37m%64s\033[0m\n\033[104;37m %-63s\033[0m\n\033[104;37m%64s\033[0m\n\n" '' "foobar" '';)" "$(alert_primary foobar)"
}

test_alert_secondary_should_return_expected_string() {
    assert_status_code 127 "$(alert_secondary)"
    assert_equals "$(printf "\033[0m\n\033[45;37m%64s\033[0m\n\033[45;37m %-63s\033[0m\n\033[45;37m%64s\033[0m\n\n" '' "foobar" '';)" "$(alert_secondary foobar)"
}

test_alert_success_should_return_expected_string() {
    assert_status_code 127 "$(alert_success)"
    assert_equals "$(printf "\033[0m\n\033[42;30m%64s\033[0m\n\033[42;30m %-63s\033[0m\n\033[42;30m%64s\033[0m\n\n" '' "[OK] foobar" '';)" "$(alert_success foobar)"
}

test_alert_danger_should_return_expected_string() {
    assert_status_code 127 "$(alert_danger)"
    assert_equals "$(printf "\033[0m\n\033[41;37m %-63s\033[0m\n\033[41;37m %-63s\033[0m\n\033[41;37m %-63s\033[0m\n\n" '!' "! [ERROR] foobar" '!';)" "$(alert_danger foobar)"
}

test_alert_warning_should_return_expected_string() {
    assert_status_code 127 "$(alert_warning)"
    assert_equals "$(printf "\033[0m\n\033[43;30m%64s\033[0m\n\033[43;30m %-63s\033[0m\n\033[43;30m%64s\033[0m\n\n" '' "[WARNING] foobar" '';)" "$(alert_warning foobar)"
}

test_alert_info_should_return_expected_string() {
    assert_status_code 127 "$(alert_info)"
    assert_equals "$(printf "\033[0m\n\033[44;37m%64s\033[0m\n\033[44;37m %-63s\033[0m\n\033[44;37m%64s\033[0m\n\n" '' "[INFO] foobar" '';)" "$(alert_info foobar)"
}

test_alert_light_should_return_expected_string() {
    assert_status_code 127 "$(alert_light)"
    assert_equals "$(printf "\033[0m\n\033[47;90m%64s\033[0m\n\033[47;90m %-63s\033[0m\n\033[47;90m%64s\033[0m\n\n" '' "foobar" '';)" "$(alert_light foobar)"
}

test_alert_dark_should_return_expected_string() {
    assert_status_code 127 "$(alert_dark)"
    assert_equals "$(printf "\033[0m\n\033[40;37m%64s\033[0m\n\033[40;37m %-63s\033[0m\n\033[40;37m%64s\033[0m\n\n" '' "foobar" '';)" "$(alert_dark foobar)"
}
