#!/bin/sh
set -e

#/*
# * This script is based on TangoMan Shoe Shell Microframework version 0.8.0-sm
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

#/**
# * TangoMan Start xmrig
# *
# * NOTE: run as root to enable "MSR MOD" which allow higher hash rate
# *
# * @author  "Matthias Morin" <mat@tangoman.io>
# * @version 0.8.0-sm
# *
# * @link    https://dev.to/courseprobe/how-to-mine-shiba-inu-shib-with-your-computer-in-under-5-minutes-in-2021-4e13
# * @link    https://unmineable.com/coins/SHIB
# *
# * @link    https://eth.nanopool.org
# * @link    https://xmr.nanopool.org
# */

#--------------------------------------------------
# Place your parameters after this line
#--------------------------------------------------

## What is your bitcoin wallet public address ? /[a-zA-Z0-9]+/
btc='3Dxh2xUgejCPWtdcmQgusJeyiYBChqRTHa'

## What is your dogecoin wallet public address ? /[a-zA-Z0-9]+/
doge='DJruqNbLiAiaTHZ7dWGtXfdoUhfCdpsyYH'

## What is your ethereum wallet public address ? /[a-zA-Z0-9]+/
eth='0xD595d5455aD343E501cb889458c5BF6F89C59f8f'

## What is your XMR wallet public address ? /[a-zA-Z0-9]+/
xmr=''

## What is your shiba inu wallet public address ? /[a-zA-Z0-9]+/
shib='0x16982149A74aE87C610F83E5f95a86133Bae89fd'

## What is the worker name ? /[a-zA-Z0-9]+/
worker='TangoMan75'

## Set xmrig binary path /~?[a-zA-Z0-9/._-]+/
path=~/.xmrig

## Huge pages size /[0-9]+/
hugepages=2048

## Referal code /[a-z0-9-]+/
referal_code='e4xd-wmzl'

## Pool url /[a-zA-Z0-9/._-]+/
pool=''

#--------------------------------------------------
# Place flags after this line
#--------------------------------------------------

## Use cuda
cuda=false

## Use nanopool.org
nanopool=false

## Use unmineable pool
unmineable=false

#--------------------------------------------------
# Place your constants after this line
#--------------------------------------------------

## nanopool url for ethereum https://eth.nanopool.org
ETH_NANOPOOL='eth-eu1.nanopool.org:9433'

## nanopool url for monero https://xmr.nanopool.org
XMR_NANOPOOL='xmr-eu1.nanopool.org:14433'

## unmineable url
UNMINEABLE='rx.unmineable.com:3333'

#--------------------------------------------------
# Place your functions after this line
#--------------------------------------------------

## Start mining bitcoins
btc() {
    _init

    if [ "${unmineable}" = true ]; then
        _echo_info "https://unmineable.com/coins/btc/address/${btc}\n"

        _echo_info "sudo ${path}/xmrig --url \"${pool}\" --user \"BTC:${btc}.${worker}#${referal_code}\" --pass x\n"
        sudo ${path}/xmrig --url "${pool}" --user "BTC:${btc}.${worker}#${referal_code}" --pass x
    else
        _echo_danger "btc not configured to use \"${pool}\"\n"
    fi
}

## Start mining dogecoins
doge() {
    _init

    if [ "${unmineable}" = true ]; then
        _echo_info "https://unmineable.com/coins/doge/address/${doge}\n"

        _echo_info "sudo ${path}/xmrig --url \"${pool}\" --user \"DOGE:${doge}.${worker}#${referal_code}\" --pass x\n"
        sudo ${path}/xmrig --url "${pool}" --user "DOGE:${doge}.${worker}#${referal_code}" --pass x
    else
        _echo_danger "doge not configured to use \"${pool}\"\n"
    fi
}

## Start mining ethereum coins
eth() {
    _init

    if [ "${unmineable}" = true ]; then
        _echo_info "https://unmineable.com/coins/eth/address/${eth}\n"

        _echo_info "sudo ${path}/xmrig --url \"${pool}\" --user \"ETH:${eth}.${worker}#${referal_code}\" --pass x\n"
        sudo ${path}/xmrig --url "${pool}" --user "ETH:${eth}.${worker}#${referal_code}" --pass x
    fi

    if [ "${nanopool}" = true ]; then
        pool="${ETH_NANOPOOL}"

        _echo_info "sudo ${path}/xmrig --url \"${pool}\" --user \"${xmr}\" --tls --coin eth --algo rx/0\n"
        sudo ${path}/xmrig --url "${pool}" --user "${xmr}" --tls --coin eth --algo rx/0
    fi
}

## Start mining shiba inu coins
shib() {
    _init

    if [ "${unmineable}" = true ]; then
        _echo_info "https://unmineable.com/coins/shib/address/${shib}\n"

        if [ "${cuda}" = true ]; then
            _echo_info "sudo ${path}/xmrig --url \"${pool}\" --user \"SHIB:${shib}.${worker}#${referal_code}\" --pass x --cuda --cuda-loader ~/.xmrig/libxmrig-cuda.so\n"
            sudo ${path}/xmrig --url "${pool}" --user "SHIB:${shib}.${worker}#${referal_code}" --pass x --cuda --cuda-loader ~/.xmrig/libxmrig-cuda.so
        else
            _echo_info "sudo ${path}/xmrig --url \"${pool}\" --user \"SHIB:${shib}.${worker}#${referal_code}\" --pass x\n"
            sudo ${path}/xmrig --url "${pool}" --user "SHIB:${shib}.${worker}#${referal_code}" --pass x
        fi
    else
        _echo_danger "shib not configured to use \"${pool}\"\n"
    fi
}

## Start mining monero
xmr() {
    _init

    if [ "${unmineable}" = true ]; then
        _echo_info "https://unmineable.com/coins/xmr/address/${xmr}\n"

        _echo_info "sudo ${path}/xmrig --url \"${pool}\" --user \"XMR:${xmr}.${worker}#${referal_code}\" --pass x\n"
        sudo ${path}/xmrig --url "${pool}" --user "XMR:${xmr}.${worker}#${referal_code}" --pass x
    fi

    if [ "${nanopool}" = true ]; then
        pool="${XMR_NANOPOOL}"

        _echo_info "sudo ${path}/xmrig --url \"${pool}\" --user \"${xmr}\" --tls --coin monero\n"
        sudo ${path}/xmrig --url "${pool}" --user "${xmr}" --tls --coin monero
    fi
}

## Config huge pages
config() {
    _echo_info 'grep Huge /proc/meminfo\n'
    grep Huge /proc/meminfo

    _echo_info "sudo sysctl -w vm.nr_hugepages=${hugepages}\n"
    sudo sysctl -w vm.nr_hugepages=${hugepages}

    # refresh kernel parameters
    _echo_info 'sysctl -p\n'
    sysctl -p

    _echo_info 'sudo sysctl -a | grep vm.nr_hugepages\n'
    sudo sysctl -a | grep vm.nr_hugepages
}

#--------------------------------------------------
# Place your private functions after this line
#--------------------------------------------------

## Init miner configuration
_init() {
    if [ "${nanopool}" = true ] && [ "${unmineable}" = true ]; then
        _echo_danger 'Configuration error : "nanopool" and "unmineable" settings are mutually exclusive\n'
        return 1
    fi

    if [ "${nanopool}" = false ] && [ "${unmineable}" = false ]; then
        _echo_danger 'Configuration error : pool setting is required\n'
        return 1
    fi

    if [ "${unmineable}" = true ]; then
        pool="${UNMINEABLE}"
    fi
}

## This allows to avoid "unused variable" shellcheck warning
_private() {
    echo "${ETH_NANOPOOL}"
    echo "${XMR_NANOPOOL}"
    echo "${UNMINEABLE}"
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
    _print_options     "${_padding}"
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
    printf "${INFO}  sh %s${INFO} [${SUCCESS}command${INFO}]${DEFAULT} " "$(basename "${0}")"
    awk -F '=' "/^[a-zA-Z0-9_]+=.+\$/ {
        if (substr(PREV, 1, 3) == \"## \" && \$1 != toupper(\$1) && substr(\$0, 1, 1) != \"_\")
        printf \"${INFO}(${SUCCESS}--%s ${WARNING}%s${INFO})${DEFAULT} \", \$1, \$2
    } { PREV = \$0 }" "$0"
    printf '\n\n'
}

_print_options() {
    # $1 = padding
    if [ -z "$1" ]; then set -- 12; fi
    printf "%bOptions:%b\n" "${WARNING}" "${DEFAULT}"
    awk -F '=' "/^[a-zA-Z0-9_]+=.+\$/ {
        if (substr(PREV, 1, 3) == \"## \" && \$1 != toupper(\$1) && substr(\$0, 1, 1) != \"_\") {
            if (match(PREV, / \/.+\//)) {
                CONSTRAINT=substr(PREV, RSTART, RLENGTH);
                ANNOTATION=substr(PREV, 4, length(PREV)-length(CONSTRAINT)-3);
                printf \"${SUCCESS}  --%-$1s ${DEFAULT}%s${SUCCESS}%s${INFO} (default: ${WARNING}%s${INFO})${EOL}\", \$1, ANNOTATION, CONSTRAINT, \$2
            } else {
                printf \"${SUCCESS}  --%-$1s ${DEFAULT}%s${INFO} (default: ${WARNING}%s${INFO})${EOL}\", \$1, substr(PREV, 4), \$2
            }
        }
    } { PREV = \$0 }" "$0"
    printf '\n'
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
        printf \"${SUCCESS}  %-$(($1+2))s ${DEFAULT}%s\n\", FUNCTION, substr(PREV, 4)
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

_get_variables() {
    # constants and private variables will be ignored
    awk -F '=' '/^[a-zA-Z0-9_]+=.+$/ {
        if (substr(PREV, 1, 3) == "## " && $1 != toupper($1) && substr($0, 1, 1) != "_")print $1
    } { PREV = $0 }' "$0"
}

#--------------------------------------------------
# Validation
#--------------------------------------------------

_get_constraints() {
    awk -v NAME="$1" -F '=' '/^[a-zA-Z0-9_]+=.+$/ {
        if (substr(PREV, 1, 3) == "## " && $1 == NAME) {match(PREV, /\/.+\//); print substr(PREV, RSTART, RLENGTH)}
    } { PREV = $0 }' "$0"
}

_validate() {
    _validate_variable=$(printf '%s' "$1" | cut -d= -f1)
    _validate_value=$(printf '%s' "$1" | cut -d= -f2)
    _validate_pattern=$(_get_constraints "${_validate_variable}")
    if [ -z "${_validate_pattern}" ]; then
        return 0
    fi
    if [ "${_validate_value}" != "$(printf '%s' "${_validate_value}" | awk "match(\$0, ${_validate_pattern}) {print substr(\$0, RSTART, RLENGTH)}")" ]; then
        printf "${DANGER}error: invalid \"%s\", expected \"%s\", \"%s\" given${EOL}" "${_validate_variable}" "${_validate_pattern}" "${_validate_value}"
        exit 1
    fi
}

#--------------------------------------------------
# Main loop
#--------------------------------------------------

_main() {
    if [ $# -lt 1 ]; then
        help
        exit 0
    fi

    _error=''
    _eval=''
    _execute=''
    _requires_value=''
    for _argument in "$@"; do
        _is_valid=false
        # check if previous argument requires value
        if [ -n "${_requires_value}" ]; then
            _eval="${_eval} ${_requires_value}=${_argument}"
            _requires_value=''
            continue
        fi
        # check argument is a valid option (must start with - or --)
        if [ -n "$(printf '%s' "${_argument}" | awk '/^--?[a-zA-Z0-9_]+$/{print}')" ]; then
            for _variable in $(_get_variables); do
                # get shorthand character
                _shorthand="$(printf '%s' "${_variable}" | awk '{$0=substr($0, 1, 1); print}')"
                if [ "${_argument}" = "--${_variable}" ] || [ "${_argument}" = "-${_shorthand}" ]; then
                    _requires_value="${_variable}"
                    _is_valid=true
                    break
                fi
            done
            if [ "${_is_valid}" = false ]; then
                _error="\"${_argument}\" is not a valid option"
                break
            fi
            continue
        fi
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
        if [ "${_is_valid}" = false ]; then
            _error="\"${_argument}\" is not a valid command"
            break
        fi
    done

    if [ -n "${_requires_value}" ]; then
        _error="\"--${_requires_value}\" requires value"
    fi

    if [ -n "${_error}" ]; then
        printf "${DANGER}error: %s${EOL}" "${_error}"
        exit 1
    fi

    for _variable in ${_eval}; do
        # invalid parameters will raise errors
        _validate "${_variable}"
        eval "${_variable}"
    done

    for _function in ${_execute}; do
        eval "${_function}"
    done
}

_main "$@"
