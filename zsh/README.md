# Zsh

## List

### [aliases.zsh](aliases.zsh)

A handful of most useful aliases.

### [arch-utils](arch-utils)

A small set of useful zsh utilities for Arch Linux package management.

If you want to use a pacman wrapper (e.g. trizen, pikaur)
create a .pacnames file in your home directory with
wrapper command names in separate lines.
Otherwise defaults to `sudo pacman`.

### [ldot.zsh](ldot.zsh)

Zsh function that lists only hidden files (aka DOTfiles) in the given directory.

### zshrc.d

Directory with various zsh configurations, usually to be sourced in the primary .zshrc file.
Preferrably link this whole directory in home.

#### [zshrc.d/agkozak-config.zsh](zshrc.d/agkozak-config.zsh)

Agkozak is an asynchronous and highly customizable zsh theme.
This file contains a sane parameters, such as custom git symbols and left-side prompt only.

## My configuration

1. Install
[zplug](https://github.com/zplug/zplug),
[fasd](https://github.com/clvv/fasd),
[starship](https://starship.rs/),
tmux
2. Put this config in `.zshrc`:

    ```zsh
    eval $(starship init zsh)

    source ~/.zplug/init.zsh

    zplug "zpm-zsh/tmux"

    zplug "yous/vanilli.sh"

    zplug "plugins/fasd", from:oh-my-zsh

    zplug "~/repos/misc/zsh", use:"{aliases,ldot}.zsh", from:local

    zplug load
    ```

3. Run `zplug install`
4. Restart your shell
