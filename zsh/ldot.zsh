function _do_ldot() {
    local dotfiles_with_null_glob=("$1"/.*(N))

    if [[ -n "$dotfiles_with_null_glob" ]]; then
        (cd $1; ls -d .*)
    fi
}

function ldot() {
    local ldot_wdir="."

    if [[ -n "$1" ]]; then
        if [[ ! -d "$1" ]]; then
            echo "$1 is not a valid directory" >&2
            return 1
        fi

        ldot_wdir="$1"
    fi

    _do_ldot "$ldot_wdir"
}

compdef "_path_files -/" ldot
