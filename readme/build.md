# Building using justbuild

MonolithVim preconfigured with few build tasks contained in [justfile](justfile), mostly for D, but any of them can be used and basic example on how to configure it.

### How to build file/project
Build type (language) is deducted from your file language (`setf` vim command). If there's build tasks available for you language (or tasks with `Any` language) they will be used for default/selective build.

Build key sequences:
- `\bb` - Builds current file/project using `Lang_Default` task.
- `\bB` - Gives you selection of tasks for the language of file you're currently in and also adds tasks with `Any` language.
- `\bT` - Gives you selection of all tasks defined in `justfile`'s.

### Config
You can configure your build tasks with justfile located in your Neovim configuration folder or with justfile located in your Current Directory.

Tasks defined in justfile in Neovim config folder are considered global and will be displayed for all of your projects.

Tasks defined in justfile in Current Directory are considered local and will be displayed only for this local project. Also note that **local tasks can override global** if they carry the same name.

Any output coming from executing tasks will be directed into *quickfix* and upon completing/failing task the bell will play using `~/.config/nvim/res/build_success.wav` or `~/.config/nvim/res/build_error.wav` accordingly. This can be changed in [lua/monolith/config/justbuild.lua](lua/monolith/config/justbuild.lua) or same file in typescript (preferred, but requires executing TypescriptToLua and executing `tstl -p ~/.config/nvim/tsconfig.json`)

#### Basic justfile configuration
This configuration if called with `\bb` from any Lua file will execute `init.lua` in project root (pwd/cwd) directory.
```conf
# Runs lua project
Lua_Default:
    lua init.lua
```

#### Filename prompt
If you want to have prompt that's going to ask you for input you need to enable positional arguments with `set positional-arguments` (only once per file) and write any amount of arguments you like.
```conf
set positional-arguments
# Asks for lua file to run
Lua_Default File:
    lua $1
```

#### Use current file
MonolithVim also supports ["keywords"](#argument-keywords-macros) (or macros) arguments which will not trigger any prompts, but instead will insert their contents instead.

```conf
set positional-arguments
# Runs file in current buffer
Lua_Default FILEPATH:
    lua $1
```

#### Advanced keyword use
Also keywords can be chained to be able to manipulate them inside of task. It is recommended to add bash (or shell of your choice) shebang (`#!/bin/bash`) after task name.
```conf
set positional-arguments
# Logs current time and date in log file with prompted message
Any_Log RELDIR FILENOEXT DATE TIME CWD Message:
    #!/bin/bash
    echo $1/$2 $3 $4: $6 >> $5/logfile.log
```

#### Language default task
Default task for language should be defined as follows: `Lang_Default` or `Lang_Default_Run`, case doesn't matter, but it's more visually pleasing when first two words (separated by underscore) are capitalised (Telescope is going to render `Lang_Build_package_width_config` as `Lang: Build package with config` and single word `Taskname` will be rendered as is). It can be called with `\bb`.
```conf
set positional-arguments
# Default task for files that doesn't have a default task
Any_Default:
    echo "Error: no task found"

# Default python task
Python_Default FILEPATH:
    python $1

# Default lua task
Lua_Default FILEPATH:
    lua $1

# Default D task
D_Default:
    dub build

D_Default_Run FILEPATH:
    rdmd $1

# NOT default python task
Python_Project:
    python __init__.py
```

#### Language tasks
Tasks defined with `Lang_Task_name` or `Any_Task_name` format will be shown in `\bB` menu.
```conf
set positional-arguments
# Will be shown for any file
Any_Info FILEPATH:
    stat $1

# Will be shown only for python
Python_Run FILEPATH:
    python $1

# Will be shown only for lua
Lua_Run FILEPATH:
    lua $1

# Will be shown only for D
D_Build_package_config Package Config:
    dub build :$1 -c $2
```

#### Overriding global tasks
Global tasks can be overriden with creating project-local justfile.

- `~/.config/nvim/justfile`:
```conf
set positional-arguments
# Will be overriden by local file
Any_Run RELPATH:
    ./$1
```
- `/project/path/justfile`:
```conf
set positional-arguments
# Overrides global
Any_Run:
    echo "I've been overriden"
```

#### Further reading on how to use `justfile` can be continued on [just github page](https://github.com/casey/just).

### Argument keywords (macros)
Keywords are always fully in upper case and will not trigger any prompts.

List of keywords:
- **FILEPATH** - full file path including file name and file extension (`/path/to/file.extension`).
- **FILENAME** - file name and extension only (`file.extension`).
- **FILEDIR** - full path excluding file (`/path/to`).
- **FILEEXT** - file extension only (`extension`).
- **FILENOEXT** - file name only (`file`).
- **CWD** - current working directory (`/path/to`).
- **RELPATH** - relative file path including name and extension (`subdir/subsubdir/file.ext` or `file.ext` if file is in CWD).
- **RELDIR** - relative file path excluding file (`subdir/subsubdir` or `.` if file in CWD)
- **TIME** - time in 24 hour format (`18:20:30`: `HH:MM:SS`).
- **DATE** - date in `DD/MM/YYYY` format (`21/12/2022`).
- **USDATE** - date in `MM/DD/YYYY` format (`12/21/2022`).
- **USERNAME** - your user name (`VimEnjoyer2006`).
- **PCNAME** - your PC name (`VimEnjoyer2006PC`)
- **OS** - your OS (`Linux`)


