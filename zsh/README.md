# Zsh

## List

### [arch-utils](arch-utils)

A small set of useful zsh utilities for Arch Linux package management.

If you want to use a pacman wrapper (e.g. trizen, pikaur)
create a .pacnames file in your home directory with
wrapper command names in separate lines.
Otherwise defaults to `sudo pacman`.

You might want to check out [pakr](https://github.com/tranzystorek-io/pakr).

### [ldot](ldot)

A wrapper for `ls` to list hidden directories and files.
Superseded by <https://github.com/tranzystorek-io/ldot>.

### zshrc.d

Directory with various zsh configurations, usually to be sourced in the primary .zshrc file.
Preferrably link this whole directory in home.

#### [zshrc.d/agkozak-config.zsh](zshrc.d/agkozak-config.zsh)

Agkozak is an asynchronous and highly customizable zsh theme.
This file contains a sane parameters, such as custom git symbols and left-side prompt only.
