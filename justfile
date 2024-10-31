#!/usr/bin/env -S just --justfile
# just reference  : https://just.systems/man/en/

@default:
    just --list

sync:
    #!/bin/bash
    # Remove old directory and copy new
    function df_merge() {
        merge -A -q -p "$2" "$1" "$2" | nvim +"file $2"
    }
    function df_file() {
        diff -q "$1" "$2"
    }
    function df_dirs() {
        diff -q -r "$1" "$2" | sed "/^\s*Only in.*$/d"
    }
    # ls SOURCE_DIR/ | grep -e ".*\.dart" | sed "s/\..*//" | while read line
    # do
    #     dart compile js BUILD_FLAGS "SOURCE_DIR/$line.dart" -o "OUTPUT_DIR/$line.js"
    # done

    cpdir() {
        # rm -rf "$2/$(basename $1)"
        # cp -r $1 $2
        df_dirs $1 $2
    }
    # Remove old file and copy new
    cpfile() {
        _fname="$2/$(basename $1)"
        # rm "$2/$(basename $1)"
        # cp $1 $2
        df_file $1 $2
    }
    # Dirs
    cpdir $XDG_CONFIG_HOME/monolith.nvim/colors $XDG_CONFIG_HOME/despair.nvim/
    cpdir $XDG_CONFIG_HOME/monolith.nvim/ftplugin $XDG_CONFIG_HOME/despair.nvim/
    cpdir $XDG_CONFIG_HOME/monolith.nvim/indent $XDG_CONFIG_HOME/despair.nvim/
    cpdir $XDG_CONFIG_HOME/monolith.nvim/syntax $XDG_CONFIG_HOME/despair.nvim/
    # Files
    cpfile $XDG_CONFIG_HOME/monolith.nvim/lua/config/theme.lua $XDG_CONFIG_HOME/despair.nvim/lua/
    cpfile $XDG_CONFIG_HOME/monolith.nvim/lua/config/filetypes.lua $XDG_CONFIG_HOME/despair.nvim/lua/
    cpfile $XDG_CONFIG_HOME/monolith.nvim/lua/config/options.lua $XDG_CONFIG_HOME/despair.nvim/lua/

