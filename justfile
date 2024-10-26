#!/usr/bin/env -S just --justfile
# just reference  : https://just.systems/man/en/

@default:
    just --list

sync:
    #!/bin/bash
    # Remove old directory and copy new
    cpdir() {
        rm -rf "$2/$(basename $1)"
        cp -r $1 $2
    }
    # Remove old file and copy new
    cpfile() {
        rm "$2/$(basename $1)"
        cp $1 $2
    }
    # Dirs
    cpdir ~/.config/monolith.nvim/after ~/.config/despair.nvim/
    cpdir ~/.config/monolith.nvim/colors ~/.config/despair.nvim/
    cpdir ~/.config/monolith.nvim/ftdetect ~/.config/despair.nvim/
    cpdir ~/.config/monolith.nvim/indent ~/.config/despair.nvim/
    cpdir ~/.config/monolith.nvim/syntax ~/.config/despair.nvim/
    # Files
    cpfile ~/.config/monolith.nvim/lua/config/theme.lua ~/.config/despair.nvim/lua/
    cpfile ~/.config/monolith.nvim/lua/config/filetypes.lua ~/.config/despair.nvim/lua/
    cpfile ~/.config/monolith.nvim/lua/config/options.lua ~/.config/despair.nvim/lua/

