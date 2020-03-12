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

function _sub_upgrade() {
    _run_pacommand -Syu
}

function _sub_clean() {
    _run_pacommand -Sc
}

function _sub_orphans() {
    local -a orphans=(${(f)"$(_run_pacommand -Qtdq)"})
    local n_orphans="${#orphans[@]}"

    if ! (( n_orphans )); then
        echo "No orphans to remove"
        return 0
    fi

    _run_pacommand -Rns "${orphans[@]}"
}

function _usage() {
    cat <<END
Usage:
    pak <opts...> <subcmds...>

Options:
    -h, --help
        Print this help message and exit

Subcommands:
    upgrade
        Upgrade all system packages

    clean
        Clean package cache

    orphans
        Remove orphaned packages
END
}

function pak() {
    local -a help
    zparseopts -D -E -M -a help \
        h -help=h

    if (( ${#help[@]} )); then
        _usage
        return 0
    fi

    if ! (( $# )); then
        _usage
        return 1
    fi

    local -U subcmds
    for entry in "$@"; do
        case $entry in
            upgrade|clean|orphans)
                subcmds+=($entry)
                ;;
            *)
                _usage
                return 1
                ;;
        esac
    done

    for cmd in ${subcmds[@]}; do
        _sub_${cmd}
    done
}

function _arch_utils_option_comp() {
    _arguments \
        {-h,--help}'[Print help message and exit]'
}

function _arch_utils_subcommand_comp() {
    local -a descriptions
    descriptions=('upgrade:Upgrade all system packages' \
                  'clean:Clean package cache' \
                  'orphans:Remove orphaned packages')
    _describe 'subcommand' descriptions
}

compdef \
    "_alternative \
    commands:subcommand:_arch_utils_subcommand_comp \
    arguments:option:_arch_utils_option_comp" \
    pak
