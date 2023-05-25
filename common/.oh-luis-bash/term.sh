#!/usr/bin/env bash
# shellcheck shell=bash
# shellcheck disable=SC2034
# shellcheck disable=SC2015

# Inside kitty
if [ "$TERM" == "xterm-kitty" ]; then

    # Fallback to xterm terminfo
    if [ ! -f "/usr/share/terminfo/x/xterm-kitty" ]; then
        # fallback to a legacy supported terminfo
        export TERM=xterm-256color
    elif [[ -n ${SSH_CLIENT+x} || -n ${SSH_TTY+x} ]]; then
        export COLORTERM=truecolor
    fi

    # Source shell integration
    if test -n "$KITTY_INSTALLATION_DIR"; then
        export KITTY_SHELL_INTEGRATION="enabled"
        source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"
    fi

    alias ssh='kitten ssh'
fi
