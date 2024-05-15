# Building using justbuild

MonolithVim preconfigured with few build tasks contained in [justfile](justfile), mostly for D, but any of them can be used and basic example on how to configure it.

### How to build file/project
Build key sequences:
- `\bd` - Builds current file/project using `default` task.
- `\bb` - Builds current file/project using `build` task.
- `\br` - Builds current file/project using `run` task.
- `\bt` - Builds current file/project using `test` task.
- `\bB` - Gives you selection of all tasks in `justdfile`.
- `\bC` - Creates template `justdfile` with included "cheatsheet".

### Config
You can configure your build tasks with  justfile located in your Current Directory. These tasks are local and will be displayed only for this local project.

Any output coming from executing tasks will be directed into *quickfix* and upon completing/failing task the bell will play using `~/.config/nvim/res/build_success.wav` or `~/.config/nvim/res/build_error.wav` accordingly. This can be changed in [lua/plugins.justbuild.lua](lua/plugins.justbuild.lua) or same file in typescript (preferred, but requires executing TypescriptToLua and executing `tstl -p ~/.config/nvim/tsconfig.json`)

#### Basic justfile configuration
This configuration if called with `\bb` from any Lua file will execute `init.lua` in project root (pwd/cwd) directory.
```conf
# Runs lua project
build:
    lua init.lua
```

#### Filename prompt
If you want to have prompt that's going to ask you for input you need to enable positional arguments with `set positional-arguments` (only once per file) and write any amount of arguments you like.
```conf
set positional-arguments
# Asks for lua file to run
run File:
    lua $1
```

#### Use current file
MonolithVim also supports ["keywords"](#argument-keywords-macros) (or macros) arguments which will not trigger any prompts, but instead will insert their contents instead.

```conf
set positional-arguments
# Runs file in current buffer
run FILEPATH:
    lua $1
```

#### Advanced keyword use
Also keywords can be chained to be able to manipulate them inside of task. It is recommended to add bash (or shell of your choice) shebang (`#!/bin/bash`) after task name.
```conf
set positional-arguments
# Logs current time and date in log file with prompted message
log RELDIR FILENOEXT DATE TIME CWD Message:
    #!/bin/bash
    echo $1/$2 $3 $4: $6 >> $5/logfile.log
```

#### Define aliases, requirements and variables
```conf
set positional-arguments

CFLAGS = -Wno

# Build both main.c and io.h
build: main_c io_h

buildWithMessage: main_c io_h
    echo 'Printed after main.c and io.h'

buildHeaderFirst: io_h && main_c
    # Will not print "echo 'Printed after io.h but before main.c'" before executing
    @echo 'Printed after io.h but before main.c'

main_c:
    gcc main.c

io_h:
    gcc io.h {{CFLAGS}}
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

### Errors
- If you are getting error that contains "__TS__StringSplit" and "find" when trying to use any of build tasks then there's probably an error with your default shell (i.e. fish printing welcome message in non-interactive (not in terminal) mode) which might result in vim.fn.shell outputing rubbish instead of contents of justfile.

