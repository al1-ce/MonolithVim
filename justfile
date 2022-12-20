# Neovim build tasks
# Task names must follow this order:
# LangName_Opt1_Opt2
#
# If language will have default build task
# which will be called with \bb then it should
# be as:
# LangName_Default
# and accept no arguments


set positional-arguments

D_Default:
    dub build

D_Build BuildType:
    dub build -b $1

D_Build_package Package:
    dub build :$1

D_Build_config Config:
    dub build -c $1

Lua_Default:
    lua init.lua

Lua_Run File:
    lua $1

Python_Default:
    python __init__.py

Python_Run File:
    python $1

GetCurrentDir:
    pwd