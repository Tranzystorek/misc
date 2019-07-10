# Zsh

## List

### [arch-utils.zsh](arch-utils.zsh)

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
