---@diagnostic disable: unused-local
local sysdep = require("utils.sysdep")
local noremap = require("map").noremap
local os_spec = require("utils.osspec")

local function ctx_callback(func)
    return {
        type = "callback",
        callback = func
    }
end

return {
    -- Async code
    'nvim-lua/plenary.nvim',
    {
        "vhyrro/luarocks.nvim",
        cond = sysdep({ "luarocks" }),
        priority = 1000,
        config = true,
        opts = {
            rocks = { "magick" },
        },
    },
    -- project manager [ \fp ]
    {
        "al1-ce/project.nvim",
        config = function()
            require("project_nvim").setup({
                show_hidden = true,
                silent_chdir = true,
                detection_methods = { "pattern" }, -- "lsp" makes it jump too much
                patterns = {
                    -- Home dir things
                    "!.xinitrc",
                    "!.bashrc",
                    -- Special
                    "!.ignore_project",
                    "!>out",
                    -- Language specific
                    ".git", ".gitignore",  -- git
                    "dub.json", "dub.sdl", -- d
                    "package.json",        -- js
                    "*.sln",               -- c#
                    -- Generic:
                    "src", "source",
                    "justfile",
                    "xmake.lua", "premake5.lua",
                    "meson.build", "build.ninja",
                    ".vscode",

                    -- Do not enable since it can be in subdirs
                    -- "Makefile", "CmakeLists.txt",
                },
            })
        end
    },
    {
        "LintaoAmons/cd-project.nvim",
        enabled = false,
        opts = {
            project_config_filepath = vim.fs.normalize(vim.fn.stdpath('data') .. "/cd-project.nvim.json"),
            patterns = {
                -- "!.ignore_project",
                -- "!>out",
                ".git", ".gitignore",  -- git
                "dub.json", "dub.sdl", -- d
                "package.json",        -- js
                "*.sln",               -- c#
                -- Generic:
                "src", "source",
                "justfile",
                "xmake.lua", "premake5.lua",
                "meson.build", "build.ninja",
                ".vscode",

                -- Do not enable since it can be in subdirs
                -- "Makefile", "CmakeLists.txt",
            },
            project_picker = "vim-ui",
            auto_register_project = false,
            hooks = {
                -- {
                --   trigger_point = "BEFORE_CD",
                --   callback = function(_)
                --     vim.print("before cd project")
                --     require("bookmarks").api.mark({name = "before cd project"})
                --   end,
                -- },
            }
        }
    },
    -- file manager as buffer [ - ]
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            default_file_explorer = true,
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<cr>"] = "actions.select",
                ["<C-s>"] = "actions.select_vsplit",
                ["<C-h>"] = "actions.select_split",
                ["<C-t>"] = "actions.select_tab",
                ["<C-p>"] = "actions.preview",
                ["q"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["gh"] = { desc = "Open home directory", callback = function(opts) require("oil").open("~") end },
                ["gc"] = "actions.open_cwd",
            },
            use_default_keymaps = false,
            delete_to_trash = true,
            view_options = {
                show_hidden = true
            }
        },
        event = "VimEnter",
        keys = {
            { "-",         "<cmd>Oil<cr>",                               mode = "n", noremap = true, silent = true, desc = "Opens parent directory" },
            { "<leader>-", function() require("oil").toggle_float() end, mode = "n", noremap = true, silent = true, desc = "Opens parent directory in float" },
        },
    },
    -- TodoTree [ \vt ]
    {
        'folke/todo-comments.nvim',
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            keywords = {
                FIX = {
                    icon = " ", -- used for the sign, and search results
                    -- can be a hex color, or a named color
                    -- named colors definitions follow below
                    color = "error",
                    -- color = "#cc241d",
                    -- a set of other keywords that all map to this FIX keywords
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }
                    -- signs = false -- configure signs for some keywords individually
                },
                TODO = { icon = " ", color = "info" },
                LINK = { icon = " ", color = "info" },
                HACK = { icon = " ", color = "warning" },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
            },
            highlight = {
                keyword = 'fg',
                after = 'empty',
            }
        },
        event = "VimEnter",
        keys = {
            { "<leader>ft", "<cmd>TodoLocList<cr>", mode = "n", noremap = true, silent = true, desc = "[F]ind [T]odo" },
        }
    },
    -- Goto quickfix files
    'yssl/QFEnter',
    -- jet another buffer switcher
    {
        'oredaze/myJABS.nvim', -- fork of a fork of a fork... of a fork
        -- 'matbme/JABS.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            keymap = {
                close = "d",   -- Close buffer. Default D
                jump = "<cr>", -- Jump to buffer. Default <cr>
                h_split = "s", -- Horizontally split buffer. Default s
                v_split = "v", -- Vertically split buffer. Default v
                preview = "p", -- Open buffer preview. Default P
            },

            symbols = {
                current = "C",      -- default 
                split = "S",        -- default 
                alternate = "A",    -- default 
                hidden = "H",       -- default ﬘
                unlisted = "U",     -- default 
                locked = "L",       -- default 
                ro = "R",           -- default 
                edited = "E",       -- default 
                terminal = "T",     -- default 
                default_file = "D", -- Filetype icon if not present in nvim-web-devicons. Default 
            },

            use_devicons = false,

            border = "none",
            relative = "cursor",
            position = { 'right', 'bottom' },

            preview = {
                -- border = 'none'
                border = require("utils.borders").normal
            }
        },
        event = "VimEnter",
        keys = {
            { "<leader>l", "<cmd>JABSOpen<cr>", mode = "n", noremap = true, silent = true, desc = "[L]ist Buffers" },
        }
    },
    {
        'ggandor/leap.nvim',
        enabled = true,
        config = function()
            local leap = require("leap")
            leap.opts.safe_labels = ''
            leap.opts.labels = 'asdghklqwertyuiopzxcvbnmfj;'
            noremap("n", "s", "<Plug>(leap)", { desc = "Leap" })
            noremap("n", "S", "<Plug>(leap-from-window)", { desc = "Leap to other window" })
        end,
    },
    -- cool smart surrounding cs ys ds
    {
        -- 'tpope/vim-surround',
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = true
    },
    -- Move lines and characters [ A-Up A-Down ]
    {
        'fedepujol/move.nvim',
        config = true,
        event = "VimEnter",
        keys = {
            { "<A-up>",    "<esc><cmd>MoveLine(-1)<cr>i", mode = "i", noremap = true, silent = true, desc = "Swaps current line with line above" },
            { "<A-down>",  "<esc><cmd>MoveLine(1)<cr>i",  mode = "i", noremap = true, silent = true, desc = "Swaps current line with line below" },
            { "<A-k>",     "<esc><cmd>MoveLine(-1)<cr>i", mode = "i", noremap = true, silent = true, desc = "Swaps current line with line above" },
            { "<A-j>",     "<esc><cmd>MoveLine(1)<cr>i",  mode = "i", noremap = true, silent = true, desc = "Swaps current line with line below" },

            -- for some reason <cmd> breaks it, probably because '<,'>
            { "<A-up>",    ":MoveBlock(-1)<cr>",          mode = "v", noremap = true, silent = true, desc = "Moves visual block up" },
            { "<A-down>",  ":MoveBlock(1)<cr>",           mode = "v", noremap = true, silent = true, desc = "Moves visual block down" },
            { "<A-right>", ":MoveHBlock(1)<cr>",          mode = "v", noremap = true, silent = true, desc = "Moves visual block right" },
            { "<A-left>",  ":MoveHBlock(-1)<cr>",         mode = "v", noremap = true, silent = true, desc = "Moves visual block left" },
            { "<A-k>",     ":MoveBlock(-1)<cr>",          mode = "v", noremap = true, silent = true, desc = "Moves visual block up" },
            { "<A-j>",     ":MoveBlock(1)<cr>",           mode = "v", noremap = true, silent = true, desc = "Moves visual block down" },
            { "<A-l>",     ":MoveHBlock(1)<cr>",          mode = "v", noremap = true, silent = true, desc = "Moves visual block right" },
            { "<A-h>",     ":MoveHBlock(-1)<cr>",         mode = "v", noremap = true, silent = true, desc = "Moves visual block left" },
        }
    },
    -- Sudo edit/save [ \hw \hr ]
    'lambdalisue/suda.vim',
    -- Session manager [ :SessionsLoad :SessionsSave ]
    {
        'natecraddock/sessions.nvim',
        opts = {
            events = { "VimLeavePre" },
            session_filepath = vim.fn.stdpath("data") .. "/sessions",
            absolute = true,
        },
        event = "VimEnter",
        keys = {
            { "<leader>SS", "<cmd>SessionsSave<cr>", mode = "n", noremap = true, silent = true, desc = "[S]ession [S]save" },
            { "<leader>SL", "<cmd>SessionsLoad<cr>", mode = "n", noremap = true, silent = true, desc = "[S]ession [L]oad" },
        }
    },
    -- remember last edited line
    {
        'ethanholz/nvim-lastplace',
        opts = {
            lastplace_ignore_buftype = { "quickfix", "nofile", "help", "alpha" },
            lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
            lastplace_open_folds = true
        }
    },
    -- .todo.md files
    {
        'aserebryakov/vim-todo-lists',
        config = function()
            vim.g.VimTodoListsUndoneItem = '- [ ]'
            vim.g.VimTodoListsDoneItem = '- [x]'
            vim.g.VimTodoListsMoveItems = 0
            vim.g.VimTodoListsKeepSameIndent = 0

            vim.cmd([[
                function! VimTodoListsCustomMappins()
                endfunction
            ]])
            vim.g.VimTodoListsCustomKeyMapper = "VimTodoListsCustomMappins"

            vim.cmd([[
                function! VimTodoListsInitFIXED()
                    setlocal tabstop=4
                    setlocal shiftwidth=4 expandtab
                endfunction

                augroup vimtodolists_auto_commands_fixed
                    autocmd!
                    autocmd BufRead,BufNewFile *.todo.md call VimTodoListsInitFIXED()
                    autocmd FileType todo call VimTodoListsInitFIXED()
                augroup end
            ]])
        end,
        keys = {
            { "<cr>",    "<cmd>VimTodoListsCreateNewItemBelow<cr>", mode = "n", ft = "todo", desc = "Add todo below" },
            { "<s-cr>",  "<cmd>VimTodoListsCreateNewItemAbove<cr>", mode = "n", ft = "todo", desc = "Add todo above" },
            { "<space>", "<cmd>VimTodoListsToggleItem<cr>",         mode = "n", ft = "todo", desc = "Toggle todo item" }
        },
        event = "VimEnter",
    },
    -- Look up at devdocs [:gd]
    {
        'romainl/vim-devdocs',
        keys = {
            { "<leader>od", "<cmd>DD<cr>", mode = "n", noremap = true, silent = true, desc = "Opens [D]ev[D]ocs for symbol under cursor" },
        }
    },
    -- better macros
    {
        "chrisgrieser/nvim-recorder",
        dependencies = { "rcarriga/nvim-notify" },
        opts = {
            -- Named registers where macros are saved (single lowercase letters only).
            -- The first register is the default register used as macro-slot after
            -- startup.
            slots = { "a", "b" },

            mapping = {
                startStopRecording = "q",
                playMacro = "Q",
                switchSlot = "<C-q>",
                editMacro = "cq",
                deleteAllMacros = "dq",
                yankMacro = "yq",
                -- ⚠️ this should be a string you don't use in insert mode during a macro
                addBreakPoint = "##",
            },

            -- Clears all macros-slots on startup.
            clear = false,

            -- Log level used for any notification, mostly relevant for nvim-notify.
            -- (Note that by default, nvim-notify does not show the levels `trace` & `debug`.)
            logLevel = vim.log.levels.DEBUG,

            -- If enabled, only critical notifications are sent.
            -- If you do not use a plugin like nvim-notify, set this to `true`
            -- to remove otherwise annoying messages.
            lessNotifications = true,

            -- Use nerdfont icons in the status bar components and keymap descriptions
            useNerdfontIcons = false,

            -- Performance optimzations for macros with high count. When `playMacro` is
            -- triggered with a count higher than the threshold, nvim-recorder
            -- temporarily changes changes some settings for the duration of the macro.
            performanceOpts = {
                countThreshold = 100,
                lazyredraw = false,        -- enable lazyredraw (see `:h lazyredraw`)
                noSystemClipboard = false, -- remove `+`/`*` from clipboard option
                autocmdEventsIgnore = {    -- temporarily ignore these autocmd events
                    -- "TextChangedI",
                    -- "TextChanged",
                    -- "InsertLeave",
                    -- "InsertEnter",
                    -- "InsertCharPre",
                },
            },

            -- [experimental] partially share keymaps with nvim-dap.
            -- (See README for further explanations.)
            dapSharedKeymaps = false,
        }
    },
    -- Move splits [ A-S-Right ... ]
    {
        'sindrets/winshift.nvim',
        event = "VimEnter",
        opts = {
            keymaps = {
                disable_defaults = false,
            }
        },
        keys = {
            { "<A-S-left>",  "<cmd>WinShift left<cr>",  mode = "n", noremap = true, silent = true, desc = "Moves window left" },
            { "<A-S-right>", "<cmd>WinShift right<cr>", mode = "n", noremap = true, silent = true, desc = "Moves window right" },
            { "<A-S-up>",    "<cmd>WinShift up<cr>",    mode = "n", noremap = true, silent = true, desc = "Moves window up" },
            { "<A-S-down>",  "<cmd>WinShift down<cr>",  mode = "n", noremap = true, silent = true, desc = "Moves window down" },
            { "<A-S-h>",     "<cmd>WinShift left<cr>",  mode = "n", noremap = true, silent = true, desc = "Moves window left" },
            { "<A-S-l>",     "<cmd>WinShift right<cr>", mode = "n", noremap = true, silent = true, desc = "Moves window right" },
            { "<A-S-k>",     "<cmd>WinShift up<cr>",    mode = "n", noremap = true, silent = true, desc = "Moves window up" },
            { "<A-S-j>",     "<cmd>WinShift down<cr>",  mode = "n", noremap = true, silent = true, desc = "Moves window down" },
        }
    },
    -- Resize splits [ A-C-Right ... ]
    {
        'mrjones2014/smart-splits.nvim',
        config = true,
        event = "VimEnter",
        keys = {
            { "<A-C-left>",  function() require('smart-splits').resize_left(2) end,  mode = "n", noremap = true, silent = true, desc = "Resizes window to left" },
            { "<A-C-right>", function() require('smart-splits').resize_right(2) end, mode = "n", noremap = true, silent = true, desc = "Resizes window to right" },
            { "<A-C-up>",    function() require('smart-splits').resize_up(2) end,    mode = "n", noremap = true, silent = true, desc = "Resizes window up" },
            { "<A-C-down>",  function() require('smart-splits').resize_down(2) end,  mode = "n", noremap = true, silent = true, desc = "Resizes window down" },
            { "<A-C-h>",     function() require('smart-splits').resize_left(2) end,  mode = "n", noremap = true, silent = true, desc = "Resizes window to left" },
            { "<A-C-l>",     function() require('smart-splits').resize_right(2) end, mode = "n", noremap = true, silent = true, desc = "Resizes window to right" },
            { "<A-C-k>",     function() require('smart-splits').resize_up(2) end,    mode = "n", noremap = true, silent = true, desc = "Resizes window up" },
            { "<A-C-j>",     function() require('smart-splits').resize_down(2) end,  mode = "n", noremap = true, silent = true, desc = "Resizes window down" },
        }
    },
    {
        "zk-org/zk-nvim",
        enabled = sysdep({ "zk" }),
        config = function()
            vim.cmd([[ let $ZK_NOTEBOOK_DIR = $HOME."/zk" ]])
            local zk = require("zk")
            local commands = require("zk.commands")
            zk.setup({
                picker = "fzf_lua",

                lsp = {
                    -- `config` is passed to `vim.lsp.start_client(config)`
                    config = {
                        cmd = { "zk", "lsp" },
                        name = "zk",
                        -- on_attach = ...
                        -- etc, see `:h vim.lsp.start_client()`
                    },

                    -- automatically attach buffers in a zk notebook that match the given filetypes
                    auto_attach = {
                        enabled = true,
                        filetypes = { "markdown" },
                    },
                },
            })
            commands.add("ZkOrphans", function(options)
                options = vim.tbl_extend("force", { orphan = true }, options or {})
                zk.edit(options, { title = "Zk Orphans" })
            end)
            commands.add("ZkNav", function(options)
                options = vim.tbl_extend("force", {
                    matchStrategy = "exact",
                    match = { "Index " },
                    -- limit = 1,
                    tags = { "nav" }
                }, options or {})
                zk.edit(options, { title = "Zk Index" })
            end)
        end,
        keys = {
            { "<leader>zk", "<cmd>ZkNotes { sort = { 'modified' } }<cr>",                                       mode = "n", noremap = true, silent = true, desc = "[Z][K] notes" },
            { "<leader>zt", "<cmd>ZkTags<cr>",                                                                  mode = "n", noremap = true, silent = true, desc = "[Z]k [T]ags" },
            { "<leader>zf", "<cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<cr>", mode = "n", noremap = true, silent = true, desc = "[Z]k [F]ind" },
            { "<leader>zh", "<cmd>ZkNav<cr>",                                                                   mode = "n", noremap = true, silent = true, desc = "[Z]k [H]ome" },
            { "<leader>zf", ":'<,'>ZkMatch<cr>",                                                                mode = "v", noremap = true, silent = true, desc = "[Z]k [F]ind" },
            {
                "<leader>zn",
                function()
                    local zk = require("zk")
                    local util = require("zk.util")
                    local title = vim.fn.input("Title: ")
                    local dir = vim.fn.input("Directory (empty to skip): ")
                    if title == "" then vim.api.nvim_err_writeln("Cannot create note without title") end
                    if dir == "" then
                        zk.new({ title = title })
                    else
                        local npath = util.notebook_root(util.resolve_notebook_path(0))
                        dir = vim.fn.fnamemodify(npath .. '/' .. dir, ":p")
                        if vim.fn.isdirectory(dir) == 0 then
                            vim.fn.mkdir(dir, 'p')
                        end
                        zk.new({ title = title, dir = dir })
                    end
                    -- "<cmd>ZkNew { title = vim.fn.input('Title: '), dir = vim.fn.input('Directory: ') }<cr>"
                end,
                mode = "n",
                noremap = true,
                silent = true,
                desc = "[Z]k [N]ew"
            },
        },
        event = "VimEnter"
    },
    {
        "jakewvincent/mkdnflow.nvim",
        opts = {
            modules = {
                bib = false,
                buffers = true,
                conceal = false,
                cursor = true,
                folds = false,
                foldtext = false,
                links = true,
                lists = false,
                maps = false,
                paths = true,
                tables = false,
                yaml = false,
                cmp = false
            },
        },
        keys = {
            { "C-]", "<cmd>MkdnFollowLink<cr>", ft = "markdown", mode = "n", noremap = true, silent = true, desc = "Follow markdown link" }
        },
        ft = "markdown"
    },
    -- easy . repeat for plugins
    "tpope/vim-repeat",
    -- close inactive buffers
    {
        'axkirillov/hbac.nvim',
        opts = {
            autoclose = true,
            threshold = 10,
            close_buffers_with_windows = false,
        }
    },
    -- Focus <cmd>number line
    { "nacro90/numb.nvim",   config = true },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
        "inkarkat/vim-SyntaxRange",
        enabled = false,
    },
    {
        -- "al1-ce/context-menu.nvim",
        dir = "/g/al1-ce/context-menu.nvim",
        opts = {
            menu_items = {
                {
                    name = "Run File",
                    hl = { bg = "#efefef", fg = "#efefef" },
                    ft = { "!markdown" },
                    cmd = function(context)
                        if context.ft == "lua" then
                            return vim.cmd([[source %]])
                        elseif context.ft == "javascript" then
                            return vim.print("run javascript:: haven't impl yet")
                        end
                    end,
                },
                {
                    name = "Sub CMD",
                    order = 1,
                    hl = "String",
                    ft = { "!markdown" },
                    sub_menu = {
                        { name = " 1.──────────── ", cmd = function() end },
                        { name = " 1.1 Cde::Format", cmd = vim.lsp.buf.format, },
                        { name = " 1.2 Coe::Format", cmd = vim.lsp.buf.format, },
                        {
                            name = "Sub CMD",
                            hl = "String",
                            ft = { "!markdown" },
                            sub_menu = {
                                { name = " 1.──────────── ", cmd = function() end },
                                { name = " 1.1 Cde::Format", cmd = vim.lsp.buf.format, },
                                { name = " 1.2 Coe::Format", cmd = vim.lsp.buf.format, },
                            },
                        },
                    },
                },
                { name = " 0──────────── ", hl = "Float", cmd = function() end },
                { name = " 1Code::Fomat", cmd = vim.lsp.buf.format, },
                { name = " 2de::Fomt", cmd = vim.lsp.buf.format, },
                { name = " 3Code::Forat", hl = "DiagnosticUnderlineError", cmd = vim.lsp.buf.format, },
                { name = " 4Code::Forat", cmd = vim.lsp.buf.format, },
                { name = " 5Code::ormat", cmd = vim.lsp.buf.format, },
                { name = " 6Code::Forat", cmd = vim.lsp.buf.format, },
                { name = " 7Code::rma", cmd = vim.lsp.buf.format, },
                { name = " 8Code::Format", cmd = vim.lsp.buf.format, },
            },
            debug = false,
            keymap = {
                close = { "q", "<ESC>" },
                confirm = { "<CR>", "o" },
                back = { "h", "<left>" }
            },
            window = {
                style = "SignColumn",
                border_style = "SignColumn",
                border = "double",
                cursor = { underline = true },
                separator = "-",
                submenu = ">",
            },
        },
        keys = {
            { "<leader>cc", function() require("context-menu").trigger_context_menu() end, mode = "n", noremap = true, silent = true, desc = "[C]ontext [M]enu" }
        },
        event = "VimEnter"
    },
    {
        "LintaoAmons/bookmarks.nvim",
        -- recommand, pin the plugin at specific version for stability
        -- backup your db.json file when you want to upgrade the plugin
        dependencies = {
            { "nvim-telescope/telescope.nvim" },
            { "stevearc/dressing.nvim" }, -- optional: to have the same UI shown in the GIF
        },
        opts = {
            -- where you want to put your bookmarks db file (a simple readable json file, which you can edit manually as well)
            json_db_path = vim.fs.normalize(vim.fn.stdpath("config") .. "/bookmarks.db.json"),
            -- This is how the sign looks.
            signs = {
                mark = { icon = "󰃁", color = "red", line_bg = "#572626" },
            },
            picker = {
                -- choose built-in sort logic by name: string, find all the sort logics in `bookmarks.adapter.sort-logic`
                -- or custom sort logic: function(bookmarks: Bookmarks.Bookmark[]): nil
                sort_by = "last_visited",
            },
            -- optional, backup the json db file when a new neovim session started and you try to mark a place
            -- you can find the file under the same folder
            enable_backup = true,
            -- optional, show the result of the calibration when you try to calibrate the bookmarks
            show_calibrate_result = true,
            -- optional, auto calibrate the current buffer when you enter it
            auto_calibrate_cur_buf = true,
            -- treeview options
            treeview = {
                bookmark_format = function(bookmark)
                    if bookmark.name ~= "" then return bookmark.name else return "[No Name]" end
                end,
                keymap = {
                    quit = { "q", "<ESC>" },
                    refresh = "R",
                    create_folder = "a",
                    tree_cut = "x",
                    tree_paste = "p",
                    collapse = "o",
                    delete = "d",
                    active = "s",
                    copy = "c",
                },
            },
            -- do whatever you like by hooks
            hooks = {
                {
                    ---a sample hook that change the working directory when goto bookmark
                    ---@param bookmark Bookmarks.Bookmark
                    ---@param projects Bookmarks.Project[]
                    callback = function(bookmark, projects)
                        local project_path
                        for _, p in ipairs(projects) do
                            if p.name == bookmark.location.project_name then
                                project_path = p.path
                            end
                        end
                        if project_path then
                            vim.cmd("cd " .. project_path)
                        end
                    end,
                },
            },
        }
    },
    {
        "notomo/cmdbuf.nvim",
        config = function()
            local cmdbuf = require("cmdbuf")
            vim.api.nvim_create_user_command("Cmdbuf", function()
                cmdbuf.split_open(vim.o.cmdwinheight)
            end, {})
            vim.api.nvim_create_user_command("Luabuf", function()
                cmdbuf.split_open(vim.o.cmdwinheight, { type = "lua/cmd" })
            end, {})
            -- vim.keymap.set("ca", "cmdbuf", "Cmdbuf")
            -- vim.keymap.set("ca", "luabuf", "Luabuf")


            -- Custom buffer mappings
            vim.api.nvim_create_autocmd({ "User" }, {
                group = vim.api.nvim_create_augroup("cmdbuf_setting", {}),
                pattern = { "CmdbufNew" },
                callback = function(args)
                    -- vim.bo.bufhidden = "wipe" -- if you don't need previous opened buffer state
                    vim.keymap.set("n", "q", [[<Cmd>quit<CR>]], { nowait = true, buffer = true })
                    vim.keymap.set("n", "dd", [[<Cmd>lua require('cmdbuf').delete()<CR>]], { buffer = true })
                    vim.keymap.set({ "n", "i" }, "<C-c>", function()
                        return cmdbuf.cmdline_expr()
                    end, { buffer = true, expr = true })
                    vim.keymap.set({ "n", "i" }, "<CR>", function()
                        cmdbuf.execute({ quit = false })
                    end, { buffer = true })
                end,
            })

            noremap("n", "<leader>cb", "<cmd>Cmdbuf<cr>", { desc = "[C]md [B]uffer" })
            noremap("n", "<leader>cl", "<cmd>Luabuf<cr>", { desc = "[C]md [L]ua buffer" })
        end
    },
    {
        "jubnzv/mdeval.nvim",
        enabled = false,
        opts = {
            -- Don't ask before executing code blocks
            require_confirmation = false,
            -- Change code blocks evaluation options.
            eval_options = {
                -- Set custom configuration for C++
                cpp = {
                    command = { "clang++", "-std=c++20", "-O0" },
                    default_header = [[
    #include <iostream>
    #include <vector>
    using namespace std;
      ]]
                },
                -- Add new configuration for Racket
                racket = {
                    command = { "racket" },    -- Command to run interpreter
                    language_code = "racket",  -- Markdown language code
                    exec_type = "interpreted", -- compiled or interpreted
                    extension = "rkt",         -- File extension for temporary files
                },
            },
        }
    },
    {
        "MagicDuck/grug-far.nvim",
        opts = true
    },
    {
        "chrisgrieser/nvim-rip-substitute",
        cmd = "RipSubstitute",
        opts = {
            popupWin = {
                title = "rip-substitute",
                border = require("utils.borders").normal,
                position = "top",
            },
            keymaps = { -- normal & visual mode, if not stated otherwise
                abort = "q",
                confirm = "<CR>",
                insertModeConfirm = "<C-CR>",
                prevSubst = "<Up>",
                nextSubst = "<Down>",
                toggleFixedStrings = "<C-f>", -- ripgrep's `--fixed-strings`
                toggleIgnoreCase = "<C-c>",   -- ripgrep's `--ignore-case`
                openAtRegex101 = "R",
            },
            prefill = {
                normal = false
            },
        },
        keys = {
            {
                "<leader>rg",
                function() require("rip-substitute").sub() end,
                mode = { "n", "x" },
                desc = "[R]ipgrep [S]ubstitute",
            },
        },
    },
    { 'djoshea/vim-autoread' },
    {
        "selectnull/plugin-readme.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            local readme = require "plugin-readme"
            vim.keymap.set("n", "<leader>pr", readme.select_plugin, {})
        end,
    },
    {
        "ezechukwu69/tui.nvim",
        config = function()
            local tui = require("tui")
            local function add_program(name, command)
                tui.setup({
                    name = name,
                    command = command,
                    width_margin = 5,
                    height_margin = 5,
                    border = require("utils.borders").normal,
                })
            end
            add_program("Ranger", "ranger")
        end,
        event = "VimEnter",
        keys = {
            { "<leader>tr", "<cmd>Ranger<cr>", desc = "[T]ui [R]anger" },
        }
    }
} -- return
