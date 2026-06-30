#!/bin/bash
set -e

#/*
# * This script is based on TangoMan Shoe Shell Microframework version 0.8.0-xs
# *
# * This file is distributed under to the MIT license.
# *
# * Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
# *
# * Permission is hereby granted, free of charge, to any person obtaining a copy
# * of this software and associated documentation files (the "Software"), to deal
# * in the Software without restriction, including without limitation the rights
# * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# * copies of the Software, and to permit persons to whom the Software is
# * furnished to do so, subject to the following conditions:
# *
# * The above copyright notice and this permission notice shall be included in all
# * copies or substantial portions of the Software.
# *
# * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# * SOFTWARE.
# *
# * Source code is available here: https://github.com/TangoMan75/shoe
# */

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * config php-xdebug
# *
# * php debug module
# *
# * @category dev
# * @link     https://xdebug.org/docs/install
# * @link     https://www.jetbrains.com/help/phpstorm/configuring-xdebug.html#updatingPhpIni
# */

## Install xdebug configuration
install() {
    # find all "xdebug.ini" files path
    find /etc/php/ -type f -name 'xdebug.ini' | while read -r XDEBUG_INI_PATH
    do
        _backup "${XDEBUG_INI_PATH}"
        _remove_xdebug_config "${XDEBUG_INI_PATH}"
        _create_xdebug_config "${XDEBUG_INI_PATH}"
        _custom_settings "${XDEBUG_INI_PATH}"
    done

    _restart_php_service "$(get_php_version)"
    version
}

## Print PHP version
get_php_version() {
    # grep -o : only matching pattern
    # grep -m1 : stop after first match
    php --version | grep -o -m1 "[0-9]\.[0-9]" | head -n1
}

## Backup xdebug configuration
_backup() {
    if [ "$#" -lt 1 ]; then
        _echo_danger "error: some mandatory argument is missing\n"
        _echo_success 'usage' 3; _echo_primary "${FUNCNAME[0]} [path]\n"

        return 1
    fi

    if [ "$#" -gt 1 ]; then
        _echo_danger "error: too many arguments (${#})\n"
        _echo_success 'usage' 3; _echo_primary "${FUNCNAME[0]} [path]\n"

        return 1
    fi

    if [ ! -e "$1" ]; then
        _echo_danger "error: invalid path ($1)\n"
        _echo_success 'usage' 3; _echo_primary "${FUNCNAME[0]} [path]\n"

        return 1
    fi

    if [ ! -d "$(get_curdir)" ]; then
        _echo_danger "error: \"$(get_curdir)\" folder does not exist\n"
        _echo_success 'usage' 3; _echo_primary "${FUNCNAME[0]} [path]\n"

        return 1
    fi

    # generate path with current date and current script name
    local BACKUP_DIR
    BACKUP_DIR="$(get_curdir)/../backups/$(date '+%Y-%m-%d')/$(basename "$0" .sh)"

    if [ ! -d "${BACKUP_DIR}" ]; then
        _echo_info "mkdir -p \"${BACKUP_DIR}\"\n"
        mkdir -p "${BACKUP_DIR}"
    fi

    if [ -d "$1" ]; then
        # copy whole directory
        _echo_info "cp -rf \"$1\" \"${BACKUP_DIR}\"\n"
        cp -rf "$1" "${BACKUP_DIR}"
    else
        # copy file
        _echo_info "cp -f \"$1\" \"${BACKUP_DIR}\"\n"
        cp -f "$1" "${BACKUP_DIR}"
    fi
}

## Remove xdebug configuration
_remove_xdebug_config() {
    if [ ! -f "$1" ]; then
        _echo_danger "error: \"$1\" file does not exist\n"
        _echo_success 'usage' 3; _echo_primary "${FUNCNAME[0]} [file_path]\n"

        return 1
    fi

    _echo_info "sudo sed -i -E '/^\[xdebug\]$/d' \"$1\"\n"
    sudo sed -i -E '/^\[xdebug\]$/d' "$1"

    _echo_info "sudo sed -i -E '/zend_extension\s?=.*xdebug/d' \"$1\"\n"
    sudo sed -i -E '/zend_extension\s?=.*xdebug/d' "$1"

    _echo_info "sudo sed -i -E '/xdebug.+=.+/d' \"$1\"\n"
    sudo sed -i -E '/xdebug.+=.+/d' "$1"
}

## Create xdebug configuration
_create_xdebug_config() {
    if [ ! -f "$1" ]; then
        _echo_danger "error: \"$1\" file does not exist\n"
        _echo_success 'usage' 3; _echo_primary "${FUNCNAME[0]} [file_path]\n"

        return 1
    fi

    if < "$1" grep -q -E 'zend_extension\s?=\s?.*xdebug'; then
        _echo_warning "xdebug settings already presents in \"$1\""
        _remove_xdebug_config "$1"
    fi

    _echo_info "cat >> \"$1\" <<EOF
[xdebug]
zend_extension=xdebug.so
xdebug.mode=debug
xdebug.client_host=127.0.0.1
xdebug.client_port=9003
xdebug.max_nesting_level=256
;xdebug.remote_autostart=1
;xdebug.remote_enable=1
;xdebug.remote_handler=dbgp
;xdebug.remote_log=/tmp/xdebug_remote.log
EOF\n"

    sudo bash -c "cat >> \"$1\" <<EOF
[xdebug]
zend_extension=xdebug.so
xdebug.mode=debug
xdebug.client_host=127.0.0.1
xdebug.client_port=9003
xdebug.max_nesting_level=256
;xdebug.remote_autostart=1
;xdebug.remote_enable=1
;xdebug.remote_handler=dbgp
;xdebug.remote_log=/tmp/xdebug_remote.log
EOF"
}

## Set default configuration
_default_settings() {
    if [ ! -f "$1" ]; then
        _echo_danger "error: \"$1\" file does not exist\n"
        _echo_success 'usage' 3; _echo_primary "${FUNCNAME[0]} [file_path]\n"

        return 1
    fi

    _set_parameter "zend_extension=xdebug.so"     "$1"
    _set_parameter "xdebug.client_host=localhost" "$1"
    _set_parameter "xdebug.client_port=9003"      "$1"
    _set_parameter "xdebug.max_nesting_level=256" "$1"
    _set_parameter "xdebug.mode=develop"          "$1"

    _unset_parameter "xdebug.remote_autostart" "$1"
    _unset_parameter "xdebug.remote_enable"    "$1"
    _unset_parameter "xdebug.remote_handler"   "$1"
    _unset_parameter "xdebug.remote_log"       "$1"
}

## Set custom configuration
_custom_settings() {
    if [ ! -f "$1" ]; then
        _echo_danger "error: \"$1\" file does not exist\n"
        _echo_success 'usage' 3; _echo_primary "${FUNCNAME[0]} [file_path]\n"

        return 1
    fi

    _set_parameter "zend_extension=xdebug.so"     "$1"
    _set_parameter "xdebug.client_host=127.0.0.1" "$1"
    _set_parameter "xdebug.client_port=9003"      "$1"
    _set_parameter "xdebug.max_nesting_level=512" "$1"
    _set_parameter "xdebug.mode=debug"            "$1"
    _set_parameter "xdebug.remote_autostart=1"    "$1"
    _set_parameter "xdebug.remote_enable=1"       "$1"
    _set_parameter "xdebug.remote_handler=dbgp"   "$1"
    _set_parameter "xdebug.remote_log=/tmp/xdebug_remote.log" "$1"
}

## Set parameter
_set_parameter() {
    if [ "$#" -lt 2 ]; then
        _echo_danger "error: some mandatory argument is missing\n"
        _echo_success 'usage' 3; _echo_primary "${FUNCNAME[0]} [ini_parameter] [file_path]\n"

        return 1
    fi

    if [ "$#" -gt 2 ]; then
        _echo_danger "error: too many arguments (${#})\n"
        _echo_success 'usage' 3; _echo_primary "${FUNCNAME[0]} [ini_parameter] [file_path]\n"

        return 1
    fi

    if [ ! -f "$2" ]; then
        _echo_danger "error: \"$2\" file does not exist\n"
        _echo_success 'usage' 3; _echo_primary "${FUNCNAME[0]} [ini_parameter] [file_path]\n"

        return 1
    fi

    # escaping slashes
    PARAMETER=$(echo "$1" | cut -d= -f1| sed 's/\//\\\//g')
    VALUE=$(echo "$1" | cut -d= -f2 | sed 's/\//\\\//g')

    _echo_secondary "setting \"${PARAMETER}=${VALUE}\"\n"

    # sed -i => edit files in place
    # sed -E => regexp extended
    _echo_info "sudo sed -i -E s/\"^;?${PARAMETER}\s?=.*$/${PARAMETER}=${VALUE}\"/g \"$2\"\n"
    sudo sed -i -E s/"^;?${PARAMETER}\s?=.*$/${PARAMETER}=${VALUE}"/g "$2"
}

## Unset parameter
_unset_parameter() {
    if [ "$#" -lt 2 ]; then
        _echo_danger "error: some mandatory argument is missing\n"
        _echo_success 'usage' 3; _echo_primary "${FUNCNAME[0]} [ini_parameter] [file_path]\n"

        return 1
    fi

    if [ "$#" -gt 2 ]; then
        _echo_danger "error: too many arguments (${#})\n"
        _echo_success 'usage' 3; _echo_primary "${FUNCNAME[0]} [ini_parameter] [file_path]\n"

        return 1
    fi

    if [ ! -f "$2" ]; then
        _echo_danger "error: \"$2\" file does not exist\n"
        _echo_success 'usage' 3; _echo_primary "${FUNCNAME[0]} [ini_parameter] [file_path]\n"

        return 1
    fi

    # escaping slashes
    PARAMETER=$(echo "$1" | cut -d= -f1| sed 's/\//\\\//g')

    _echo_secondary "unset \"${PARAMETER}\""

    # sed -i => edit files in place
    # sed -E => regexp extended
    _echo_info "sudo sed -i -E s/\"(^${PARAMETER}\s?=.*$)/;\1\"/g \"$2\"\n"
    sudo sed -i -E s/"(^${PARAMETER}\s?=.*$)/;\1"/g "$2"
}

## Get curdir
get_curdir() {
    dirname "$(realpath "${BASH_SOURCE[0]}")"
}

## Get PHP ini path
get_php_ini_path() {
    php -i 2>/dev/null | grep -E "Loaded Configuration File => .+php.ini" | sed 's/Loaded Configuration File => //'
}

## Get xdebug ini path
get_xdebug_ini_path() {
    local XDEBUG_INI_PATH

    find /etc/php/ -type f -name 'xdebug.ini' | while read -r XDEBUG_INI_PATH
    do
        echo "${XDEBUG_INI_PATH}"
    done
}

## Get xdebug bin path
get_xdebug_bin_path() {
    local XDEBUG_BIN_PATH

    XDEBUG_BIN_PATH=$(find /usr/lib/php/ -name 'xdebug.so' | grep xdebug.so)

    echo "${XDEBUG_BIN_PATH}"
}

## Restart php service
_restart_php_service() {
    if [ "$#" -lt 1 ]; then
        _echo_danger "error: some mandatory argument is missing\n"
        _echo_success 'usage' 3; _echo_primary "${FUNCNAME[0]} [version]\n"

        return 1
    fi

    if [ "$#" -gt 1 ]; then
        _echo_danger "error: too many arguments (${#})\n"
        _echo_success 'usage' 3; _echo_primary "${FUNCNAME[0]} [version]\n"

        return 1
    fi

    _echo_info "sudo systemctl restart \"php$1-fpm\"\n"
    sudo systemctl restart "php$1-fpm"
}

## Open in sublime text
open_in_sublime_text() {
    PHP_INI_PATH=$(get_php_ini_path)
    find /etc/php/ -type f -name 'xdebug.ini' | while read -r XDEBUG_INI_PATH
    do
        sudo subl "${XDEBUG_INI_PATH}"
    done
    sudo subl "${PHP_INI_PATH}"
}

## Print version infos
version() {
    local VERSION
    VERSION=$(get_php_version)

    _echo_info "php -v\n"
    php -v

    _echo_info "php-fpm${VERSION} -v\n"
    php-fpm"$(get_php_version)" -v

    _echo_info "php -v | grep -i xdebug\n"
    php -v | grep -i xdebug

    # list installed modules
    _echo_info "php -m | grep xdebug\n"
    php -m | grep xdebug

    _echo_info "php --ini | grep xdebug\n"
    php --ini | grep xdebug

    _echo_success 'xdebug ini path\n'
    get_xdebug_ini_path

    _echo_success 'xdebug bin path\n'
    get_xdebug_bin_path

    _echo_success 'php ini path\n'
    get_php_ini_path

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
# Self documentation
#--------------------------------------------------

### Help

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
    printf "${EOL}${_alert_primary}%64s${EOL}${_alert_primary} %-63s${EOL}${_alert_primary}%64s${EOL}\n" '' "$1" '';
}

_print_infos() {
    # $1 = padding
    if [ -z "$1" ]; then set -- 12; fi
    printf "%bInfos:%b\n" "${WARNING}" "${DEFAULT}"
    printf "${SUCCESS}  %-$1s ${DEFAULT}%s\n" 'author'  "$(_get_docbloc 'author')"
    printf "${SUCCESS}  %-$1s ${DEFAULT}%s\n" 'version' "$(_get_docbloc 'version')"
    printf "${SUCCESS}  %-$1s ${DEFAULT}%s\n" 'link'    "$(_get_docbloc 'link')"
    printf '\n'
}

_print_description() {
    printf "%bDescription:%b\n" "${WARNING}" "${DEFAULT}"
    printf "\033[97m  %s${EOL}\n" "$(printf '%s' "$1" | fold -w 64 -s)"
}

_print_usage() {
    printf "%bUsage:%b\n" "${WARNING}" "${DEFAULT}"
    printf "${INFO}  sh %s${INFO} [${SUCCESS}command${INFO}]${DEFAULT}\n\n" "$(basename "${0}")"
}

_print_commands() {
    # $1 = padding
    if [ -z "$1" ]; then set -- 12; fi
    printf "%bCommands:%b\n" "${WARNING}" "${DEFAULT}"
    awk "/^### /{printf\"\n${WARNING}%s:${EOL}\",substr(\$0,5)}
        /^(function )? *[a-zA-Z0-9_]+ *\(\) *\{/ {
        sub(\"^function \",\"\"); gsub(\"[ ()]\",\"\");
        FUNCTION = substr(\$0, 1, index(\$0, \"{\"));
        sub(\"{\$\", \"\", FUNCTION);
        if (substr(PREV, 1, 3) == \"## \" && substr(\$0, 1, 1) != \"_\")
        printf \"${SUCCESS}  %-$1s ${DEFAULT}%s\n\", FUNCTION, substr(PREV, 4)
    } { PREV = \$0 }" "$0"
    printf '\n'
}

#--------------------------------------------------
# Docbloc parsing
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
# Core
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
# Main loop
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
            _shorthand="$(printf '%s' "${_function}" | awk '{$0=substr($0, 1, 1); print}')"
            if [ "${_argument}" = "${_function}" ] || [ "${_argument}" = "${_shorthand}" ]; then
                # append argument to the execute stack
                _execute="${_execute} ${_function}"
                _is_valid=true
                break
            fi
        done
        # unknown parameters will raise errors
        if [ "${_is_valid}" = false ]; then
            printf "${DANGER}error: \"%s\" is not a valid command${EOL}" "${_argument}"
            exit 1
        fi
    done

    for _function in ${_execute}; do
        eval "${_function}"
    done
}

_main "$@"
