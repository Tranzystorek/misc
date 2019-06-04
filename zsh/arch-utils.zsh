# a set of useful utilities for pacman actions

function _is_command() {
    command -v "$1" >& /dev/null
}

function _exists_pacnames_file() {
    [[ -f ~/.pacnames ]]
}

function _get_pacommand() {
    if ! _exists_pacnames_file; then
        echo "sudo pacman"
        return 0
    fi

    local result_command="sudo pacman"
    for pacname in "${(f)"$(sed -E -e "s/\#.*//" -e "/^\s*$/d" "$HOME/.pacnames")"}"; do
        if _is_command "$pacname"; then
            result_command="$pacname"
            break
        fi
    done

    echo "$result_command"
}

function _run_pacommand() {
    local pacommand="$(_get_pacommand)"
    eval $pacommand $*
}

function _upgrade_packages() {
    _run_pacommand -Syu
}

function _clean_pkg_cache() {
    _run_pacommand -Sc
}

function _remove_orphans() {
    local -a orphans
    orphans=("${(@f)"$(_run_pacommand -Qtdq)"}")

    if [[ -z ${orphans[*]} ]]; then
        echo "No orphans to remove"
        return 0
    fi

    _run_pacommand -Rns "${orphans[@]}"
}

function _usage() {
    cat <<END
Usage:
    pak <opts...>

Options:

    --upgrade
        Upgrade all system packages

    --clean
        Clean package cache

    --orphans
        Remove orphaned packages

    --help, -h
        Print this help message and exit
END
}

function pak() {
    local -a cmds help
    zparseopts -D -a cmds -upgrade -clean -orphans -help=help h=help

    if [[ ${#help[@]} -gt 0 ]]; then
        _usage
        return 0
    fi

    if [[ ${#cmds[@]} -eq 0 || $# -ne 0 ]]; then
        _usage
        return 1
    fi

    for cmd in ${cmds[@]}; do
        case $cmd in
            --upgrade)
                _upgrade_packages
                ;;
            --clean)
                _clean_pkg_cache
                ;;
            --orphans)
                _remove_orphans
                ;;
        esac
    done
}

compdef \
    "_arguments \
    '--upgrade[Upgrade all system packages]' \
    '--clean[Clean package cache]' \
    '--orphans[Remove orphaned packages]' \
    '--help[Print help message and exit]'" \
    pak
