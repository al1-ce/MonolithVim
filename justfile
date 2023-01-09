# Neovim build tasks

set positional-arguments

D_Default:
    dub build

D_Default_Run:
    dub run

D_Build BuildType:
    dub build -b $1

D_Build_package Package:
    dub build :$1

D_Build_config Config:
    dub build -c $1

D_Run FILEPATH:
    $1

Lua_Default:
    lua init.lua

Lua_Run FILEPATH:
    lua $1

Python_Default:
    python __init__.py

Python_Run FILEPATH:
    python $1

Typescript_To_Lua:
    tstl -p tsconfig.json

