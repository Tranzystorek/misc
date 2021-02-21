# Dotfiles

## About

Files under this directory are dotfiles with various configurations.
For the sake of readability the dots are removed -- preferably install them with:

`ln -s <dotfile-path> .<dotfile-name>`

## List

### gitconfig

Saner config for git, including:

* [icdiff](https://www.jefftk.com/icdiff) as a difftool; displays nice split diffs in the command line
* meld as a mergetool with sane options and diff3 conflict style

### tmux.conf

Saner config for tmux.

### starship.toml

QoL config for the [Starship prompt](https://starship.rs/).

Symlink under ~/.config
