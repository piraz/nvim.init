#!/bin/bash

LINK_TARGET="$(cd "$(dirname "$0")"/.. && pwd)"
TARGET="$HOME/.config/nvim"

if [ -L "$TARGET" ]; then
    CURRENT_TARGET="$(readlink "$TARGET")"
    if [ "$CURRENT_TARGET" != "$LINK_TARGET" ]; then
        echo "Symlink exists but points to $CURRENT_TARGET. Updating to $LINK_TARGET"
        rm "$TARGET"
        ln -s "$LINK_TARGET" "$TARGET"
    fi
elif [ -d "$TARGET" ]; then
    echo "$TARGET is a directory. Removing and linking to $LINK_TARGET"
    rm -rf "$TARGET"
    ln -s "$LINK_TARGET" "$TARGET"
elif [ -e "$TARGET" ]; then
    echo "$TARGET exists but is not a directory or symlink. Removing and linking to $LINK_TARGET"
    rm "$TARGET"
    ln -s "$LINK_TARGET" "$TARGET"
else
    echo "$TARGET does not exist. Creating symlink to $LINK_TARGET"
    ln -s "$LINK_TARGET" "$TARGET"
fi

echo "Neovim configured."
