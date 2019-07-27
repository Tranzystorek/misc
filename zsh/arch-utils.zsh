# a set of useful utilities for pacman actions
# see pak --help for more info

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
    -u, --upgrade
        Upgrade all system packages

    -c, --clean
        Clean package cache

    -o, --orphans
        Remove orphaned packages

    -h, --help
        Print this help message and exit
END
}

function pak() {
    local -a cmds help
    zparseopts -D -M -a cmds \
        u -upgrade=u \
        c -clean=c \
        o -orphans=o \
        h=help -help=h

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
            -u|--upgrade)
                _upgrade_packages
                ;;
            -c|--clean)
                _clean_pkg_cache
                ;;
            -o|--orphans)
                _remove_orphans
                ;;
        esac
    done
}

compdef \
    "_arguments \
    {-u,--upgrade}'[Upgrade all system packages]' \
    {-c,--clean}'[Clean package cache]' \
    {-o,--orphans}'[Remove orphaned packages]' \
    {-h,--help}'[Print help message and exit]'" \
    pak
