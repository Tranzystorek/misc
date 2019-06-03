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

function upgrade_packages() {
    _run_pacommand -Syu
}

function clean_pkg_cache() {
    _run_pacommand -Sc
}

function remove_orphans() {
    local -a orphans
    orphans=("${(@f)"$(_run_pacommand -Qtdq)"}")

    if [[ -z ${orphans[*]} ]]; then
        echo "No orphans to remove"
        return 0
    fi

    _run_pacommand -Rns "${orphans[@]}"
}
