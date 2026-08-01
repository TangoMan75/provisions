#!/bin/sh
set -e

#/*
## This file is part of TangoMan Entrypoint package.
##
## Copyright (c) 2023 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## TangoMan CI Manager
##
## Run Continuous Integration
##
## @license MIT
## @author  "Matthias Morin" <mat@tangoman.io>
## @version 2.4.1-light
## @link    https://github.com/TangoMan75/entrypoint

## Return staged bash files
get_staged_bash_files() {
    if [ ! -x "$(command -v git)" ]; then
        _echo_danger "error: \"$(basename "${0}")\" requires git, try: 'sudo apt-get install -y git'\n"
        exit 1
    fi

    if git rev-parse --verify HEAD >/dev/null 2>&1; then
        against=HEAD
    else
        # Initial commit: diff against an empty tree object
        against=$(git hash-object -t tree /dev/null)
    fi

    # --diff-filter
    # A Added
    # C Copied
    # M Modified
    # R Renamed
    git diff-index --cached --name-only --diff-filter=ACMR "${against}" | grep \
        -e '\.bashrc' \
        -e '\.zshrc' \
        -e '\.bash_profile' \
        -e '\.sh$' || true
}

## Return staged php files
get_staged_php_files() {
    if [ ! -x "$(command -v git)" ]; then
        _echo_danger "error: \"$(basename "${0}")\" requires git, try: 'sudo apt-get install -y git'\n"
        exit 1
    fi

    if git rev-parse --verify HEAD >/dev/null 2>&1; then
        against=HEAD
    else
        # Initial commit: diff against an empty tree object
        against=$(git hash-object -t tree /dev/null)
    fi

    # --diff-filter
    # A Added
    # C Copied
    # M Modified
    # R Renamed
    git diff-index --cached --name-only --diff-filter=ACMR "${against}" | grep -e '\.php$'
}

## Install git hooks
hooks() {
    _echo_info 'rm -fr .git/hooks\n'
    rm -fr .git/hooks

    _echo_info 'cp -r .githooks .git/hooks\n'
    cp -r .githooks .git/hooks

    _echo_info 'chmod +x .git/hooks/*\n'
    chmod +x .git/hooks/*
}

## Install bash_unit framework
install() {
    if [ ! -d ./tests ]; then
        mkdir -p ./tests

    cat > "./tests/test_sample.sh" <<EOF
#!/bin/bash

# https://github.com/pgrange/bash_unit
#
#     assert "test -e /tmp/the_file"
#     assert_fails "grep this /tmp/the_file" "should not write 'this' in /tmp/the_file"
#     assert_status_code 25 code
#     assert_equals "a string" "another string" "a string should be another string"
#     assert_not_equals "a string" "a string" "a string should be different from another string"
#     fake ps echo hello world

test_can_fail() {
    fail "You need to write some tests"
}
EOF
    fi

    if [ ! -f "./tests/bash_unit" ]; then
        if [ -x "$(command -v wget)" ]; then
            _echo_info "wget -qO \"./tests/bash_unit\" https://raw.githubusercontent.com/pgrange/bash_unit/master/bash_unit\n"
            wget -qO "./tests/bash_unit" https://raw.githubusercontent.com/pgrange/bash_unit/master/bash_unit

        elif [ -x "$(command -v curl)" ]; then
            _echo_info "curl -sSL -o \"./tests/bash_unit\" https://raw.githubusercontent.com/pgrange/bash_unit/master/bash_unit\n"
            curl -sSL -o "./tests/bash_unit" https://raw.githubusercontent.com/pgrange/bash_unit/master/bash_unit

        else
            _echo_danger "error: could not find \"bash_unit\" executable, please install manually\n"
            exit 1
        fi
    fi

    if [ ! -x "./tests/bash_unit" ]; then
        _echo_info "chmod +x \"./tests\"/bash_unit\n"
        chmod +x ./tests/bash_unit
    fi
}

## Sniff errors with linter
lint() {
    if [ ! -x "$(command -v shellcheck)" ]; then
        _echo_danger "error: \"$(basename "${0}")\" requires shellcheck, try: 'sudo apt-get install -y shellcheck'\n"
        exit 1
    fi

    find . -maxdepth 3 -type f -name '*.sh' | sort -t '\0' -n | while read -r FILE
    do
        _echo_info "shellcheck \"${FILE}\"\n"
        shellcheck "${FILE}"
    done
}

## Run tests
tests() {
    find ./tests -maxdepth 3 -type f -name 'test_*.sh' | sort -t '\0' -n | while read -r FILE
    do
        _echo_info "./tests/bash_unit -f tap \"${FILE}\"\n"
        ./tests/bash_unit -f tap "${FILE}"
    done
}

#--------------------------------------------------
# Colors global variables
#--------------------------------------------------

# shellcheck disable=SC2034
{
    PRIMARY='\033[97m'; SECONDARY='\033[94m'; SUCCESS='\033[32m'; DANGER='\033[31m'; WARNING='\033[33m'; INFO='\033[95m'; LIGHT='\033[47;90m'; DARK='\033[40;37m'; DEFAULT='\033[0m'; EOL='\033[0m\n';
    _alert_primary='\033[1;104;97m'; _alert_secondary='\033[1;45;97m'; _alert_success='\033[1;42;97m'; _alert_danger='\033[1;41;97m'; _alert_warning='\033[1;43;97m'; _alert_info='\033[1;44;97m'; _alert_light='\033[1;47;90m'; _alert_dark='\033[1;40;37m';
}

#--------------------------------------------------
# A semantic set of colors functions
#--------------------------------------------------

# Synopsys: echo_* [string] (indentation) (padding)
_echo_primary()   { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${PRIMARY}"    "$3" "$1" "${DEFAULT}"; }
_echo_secondary() { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${SECONDARY}"  "$3" "$1" "${DEFAULT}"; }
_echo_success()   { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${SUCCESS}"    "$3" "$1" "${DEFAULT}"; }
_echo_danger()    { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${DANGER}"     "$3" "$1" "${DEFAULT}"; }
_echo_warning()   { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${WARNING}"    "$3" "$1" "${DEFAULT}"; }
_echo_info()      { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${INFO}"       "$3" "$1" "${DEFAULT}"; }
_echo_light()     { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${LIGHT}"      "$3" "$1" "${DEFAULT}"; }
_echo_dark()      { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${DARK}"       "$3" "$1" "${DEFAULT}"; }

# Synopsys: alert_* [string]
_alert_primary()   { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${_alert_primary}"   '' "${_alert_primary}"   "$1" "${_alert_primary}"   ''; }
_alert_secondary() { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${_alert_secondary}" '' "${_alert_secondary}" "$1" "${_alert_secondary}" ''; }
_alert_success()   { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${_alert_success}"   '' "${_alert_success}"   "$1" "${_alert_success}"   ''; }
_alert_danger()    { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${_alert_danger}"    '' "${_alert_danger}"    "$1" "${_alert_danger}"    ''; }
_alert_warning()   { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${_alert_warning}"   '' "${_alert_warning}"   "$1" "${_alert_warning}"   ''; }
_alert_info()      { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${_alert_info}"      '' "${_alert_info}"      "$1" "${_alert_info}"      ''; }
_alert_light()     { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${_alert_light}"     '' "${_alert_light}"     "$1" "${_alert_light}"     ''; }
_alert_dark()      { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${_alert_dark}"      '' "${_alert_dark}"      "$1" "${_alert_dark}"      ''; }

#--------------------------------------------------
# You do not need to worry about anything that's
# placed after this line. ;-)
#--------------------------------------------------

## Print this help (default)
help() {
    _padding=$(_get_padding)

    _print_title       "$(_get_docbloc_title)"
    _print_infos       "${_padding}"
    _print_description "$(_get_docbloc_description)"
    _print_usage
    _print_commands    "${_padding}"
}

#--------------------------------------------------

_print_title() {
    printf "\033[0m\n\033[1;104;97m%64s\033[0m\n\033[1;104;97m %-63s\033[0m\n\033[1;104;97m%64s\033[0m\n\n" '' "$1" '';
}

_print_infos() {
    _padding="$1"
    printf '\033[33mInfos:\033[0m\n'
    printf "\033[32m  %-${_padding}s \033[0m%s\n" 'author'  "$(_get_docbloc 'author')"
    printf "\033[32m  %-${_padding}s \033[0m%s\n" 'license' "$(_get_docbloc 'license')"
    printf "\033[32m  %-${_padding}s \033[0m%s\n" 'version' "$(_get_docbloc 'version')"
    printf "\033[32m  %-${_padding}s \033[0m%s\n" 'link'    "$(_get_docbloc 'link')"
    printf '\n'
}

_print_description() {
    printf '\033[33mDescription:\033[0m\n'
    printf '\033[97m  %s\033[0m\n\n' "$(echo "$1" | fold -w 64 -s)"
}

_print_usage() {
    printf '\033[33mUsage:\033[0m\n'
    printf '\033[95m  sh %s\033[95m [\033[32mcommand\033[95m]\033[0m ' "$(basename "$0")"
    awk -F '=' '/^[a-zA-Z0-9_]+=.+$/ {
        if (substr(PREV, 1, 3) == "## " && $1 != toupper($1) && $2 != "false" && substr($0, 1, 1) != "_")
        printf "\033[95m(\033[32m--%s=\033[33m%s\033[95m)\033[0m ", $1, $2
    } { PREV = $0 }' "$0"
    awk -F '=' '/^[a-zA-Z0-9_]+=false$/ {
        if (substr(PREV, 1, 3) == "## " && $1 != toupper($1) && $2 == "false" && substr($0, 1, 1) != "_")
        printf "\033[95m(\033[32m--%s\033[95m)\033[0m ", $1
    } { PREV = $0 }' "$0"
    printf '\n\n'
}

_print_commands() {
    printf '\033[33mCommands:\033[0m\n'
    awk -v PADDING="$1" '/^(function )? *[a-zA-Z0-9_]+ *\(\) *\{/ {
        sub("^function ",""); gsub("[ ()]","");
        FUNCTION = substr($0, 1, index($0, "{"));
        sub("{$", "", FUNCTION);
        if (substr(PREV, 1, 3) == "## " && substr($0, 1, 1) != "_")
        printf "\033[32m  %-*s \033[0m%s\n", PADDING+2, FUNCTION, substr(PREV, 4)
    } { PREV = $0 }' "$0"
    printf '\n'
}

#--------------------------------------------------

_get_docbloc_title() {
    awk '/^#\/\*\*$/,/^# \*\/$/{i+=1; if (i==2) print substr($0, 5)}' "$0"
}

_get_docbloc_description() {
    awk '/^# \* @/ {i=2} /^#\/\*\*$/,/^# \*\/$/{i+=1; if (i>3) printf "%s ", substr($0, 5)}' "$0"
}

_get_docbloc() {
    awk -v TAG="$1" '/^#\/\*\*$/,/^# \*\/$/{if($3=="@"TAG){for(i=4;i<=NF;++i){printf "%s ",$i}}}' "$0"
}

_get_padding() {
    awk -F '=' '/^[a-zA-Z0-9_]+=.+$/ { MATCH = $1 }
    /^(function )? *[a-zA-Z0-9_]+ *\(\) *\{/ {
        sub("^function ",""); gsub("[ ()]","");
        MATCH = substr($0, 1, index($0, "{"));
        sub("{$", "", MATCH);
    } { if (substr(PREV, 1, 3) == "## " && substr(MATCH, 1, 1) != "_" && length(MATCH) > LENGTH) LENGTH = length(MATCH) }
    { PREV = $0 } END { print LENGTH+1 }' "$0"
}

#--------------------------------------------------

_get_functions() {
    # this regular expression matches functions with either bash or sh syntax
    awk '/^(function )? *[a-zA-Z0-9_]+ *\(\) *\{/ {
        sub("^function ",""); gsub("[ ()]","");   # remove leading "function ", round brackets and extra spaces
        FUNCTION = substr($0, 1, index($0, "{")); # truncate string after opening curly brace
        sub("{$", "", FUNCTION);                  # remove trailing curly brace
        if (substr(PREV, 1, 3) == "## " && substr($0, 1, 1) != "_") print FUNCTION
    } { PREV = $0 }' "$0"
}

#--------------------------------------------------

_main() {
    if [ $# -lt 1 ]; then
        help
        exit 0
    fi

    _execute=''
    for _argument in "$@"; do
        _is_valid=false
        for _function in $(_get_functions); do
            # get shorthand character
            _shorthand="$(echo "${_function}" | awk '{$0=substr($0, 1, 1); print}')"
            if [ "${_argument}" = "${_function}" ] || [ "${_argument}" = "${_shorthand}" ]; then
                # append argument to the execute stack
                _execute="${_execute} ${_function}"
                _is_valid=true
                break
            fi
        done
        if [ "${_is_valid}" = false ]; then
            printf '\033[1;31merror:\t\033[0;91m"%s" is not a valid command\033[0m\n' "${_argument}"
            help
            exit 1
        fi
    done

    for _function in ${_execute}; do
        eval "${_function}"
    done
}

_main "$@"
