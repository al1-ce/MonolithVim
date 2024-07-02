---@diagnostic disable: unused-local
local sysdep = require("utils.sysdep")
local noremap = require("utils.noremap")
local os_spec = require("utils.osspec")

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
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup({
                show_hidden = true,
                silent_chdir = true,
                detection_methods = { "pattern" }, -- "lsp" makes it jump too much
                patterns = {
                    "dub.json", "dub.sdl",         -- d
                    ".git", ".gitignore",          -- git
                    "src", "source",               -- general
                    "package.json",                -- js
                    "*.sln",                       -- c#
                }
            })
        end
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
        'matbme/JABS.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            keymap = {
                close = "d",   -- Close buffer. Default D
                jump = "<cr>", -- Jump to buffer. Default <cr>
                h_split = "s", -- Horizontally split buffer. Default s
                v_split = "v", -- Vertically split buffer. Default v
                preview = "p", -- Open buffer preview. Default P
            },

            border = "none",
            -- border = { "┌", " ", "┐", " ", "┘", " ", "└", " " },
            relative = "cursor",
            position = { 'right', 'bottom' },

            preview = {
                -- border = 'none'
                border = { "┌", " ", "┐", " ", "┘", " ", "└", " " },
            }
        },
        event = "VimEnter",
        keys = {
            { "<leader>B", "<cmd>JABSOpen<cr>", mode = "n", noremap = true, silent = true, desc = "Opens [B]uffer switcher" },
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
    -- Remove search highlight automatically
    {
        "nvimdev/hlsearch.nvim",
        event = { "BufRead" },
        config = true,
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

            -- for some reason <cmd> breaks it, probably because '<,'>
            { "<A-up>",    ":MoveBlock(-1)<cr>",          mode = "v", noremap = true, silent = true, desc = "Moves visual block up" },
            { "<A-down>",  ":MoveBlock(1)<cr>",           mode = "v", noremap = true, silent = true, desc = "Moves visual block down" },
            { "<A-right>", ":MoveHBlock(1)<cr>",          mode = "v", noremap = true, silent = true, desc = "Moves visual block right" },
            { "<A-left>",  ":MoveHBlock(-1)<cr>",         mode = "v", noremap = true, silent = true, desc = "Moves visual block left" },
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
            { "<leader>gd", "<cmd>DD<cr>", mode = "n", noremap = true, silent = true, desc = "Opens [D]ev[D]ocs for symbol under cursor" },
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
        config = function()
            vim.cmd([[ let $ZK_NOTEBOOK_DIR = $HOME."/zk" ]])
            require("zk").setup({
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
        end,
        keys = {
            { "<leader>zk", "<cmd>ZkNotes { sort = { 'modified' } }<cr>",                                       mode = "n", noremap = true, silent = true, desc = "[Z][K] notes" },
            { "<leader>zn", "<cmd>ZkNew { title = vim.fn.input('Title: ') }<cr>",                               mode = "n", noremap = true, silent = true, desc = "[Z]k [N]ew" },
            { "<leader>zt", "<cmd>ZkTags<cr>",                                                                  mode = "n", noremap = true, silent = true, desc = "[Z]k [T]ags" },
            { "<leader>zf", "<cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<cr>", mode = "n", noremap = true, silent = true, desc = "[Z]k [F]ind" },
            { "<leader>zf", ":'<,'>ZkMatch<cr>",                                                                mode = "v", noremap = true, silent = true, desc = "[Z]k [F]ind" },
        },
        event = "VimEnter"
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
    { "nacro90/numb.nvim", config = true },
}
