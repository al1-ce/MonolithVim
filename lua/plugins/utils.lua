local sysdep = require("utils.sysdep")
local noremap = require("utils.noremap")

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
            view_options = {
                show_hidden = true
            }
        },
        event = "VimEnter",
        keys = {
            { "-", "<cmd>Oil<cr>", mode = "n", noremap = true, silent = true, desc = "Opens parent directory" },
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
            { "<leader>b", "<cmd>JABSOpen<cr>", mode = "n", noremap = true, silent = true, desc = "Opens buffer switcher" },
        }
    },

    -- Jump with keys [ s ]
    {
        'easymotion/vim-easymotion',
        config = function()
            local g = vim.g             -- global variables

            g.EasyMotion_do_mapping = 0 -- Disable default mappings
            g.EasyMotion_use_upper = 0
            g.EasyMotion_smartcase = 1
            g.EasyMotion_use_smartsign_us = 1
        end,
        keys = {
            { "S", "<Plug>(easymotion-overwin-f)",  mode = "n", noremap = true, silent = true, desc = "Starts easymotion with one key" },
            { "s", "<Plug>(easymotion-overwin-f2)", mode = "n", noremap = true, silent = true, desc = "Starts easymotion with two keys" },
        }
    },
    -- Remove search highlight automatically
    { "nvimdev/hlsearch.nvim", event = { "BufRead" }, config = true },

    -- cool smart surrounding [ \tr \tR ]
    'tpope/vim-surround',
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
            lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
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

            local function setKeymapFiletype(ft, name, mode, map, action)
                vim.api.nvim_create_autocmd('FileType', {
                    pattern = ft,
                    group = vim.api.nvim_create_augroup(name, { clear = true }),
                    callback = function()
                        noremap(mode, map, action, { buffer = true })
                    end
                })
            end

            -- TODO: rewrite with lazy keys using ft="todo"
            setKeymapFiletype('todo', 'TodoAddNew', 'n', '<cr>', '<cmd>VimTodoListsCreateNewItemBelow<cr>')
            setKeymapFiletype('todo', 'TodoAddNewAbove', 'n', '<A-CR>', '<cmd>VimTodoListsCreateNewItemAbove<cr>')
            setKeymapFiletype('todo', 'TodoToggle', 'n', '<Space>', '<cmd>VimTodoListsToggleItem<cr>')

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
        end
    },
    -- Look up at devdocs [:gd]
    {
        'romainl/vim-devdocs',
        keys = {
            { "<leader>gd", "<cmd>DD<cr>", mode = "n", noremap = true, silent = true, desc = "Opens devdocs for symbol under cursor" },
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
    -- view images in terminal
    {
        "3rd/image.nvim",
        dependencies = { "luarocks.nvim" },
        cond = sysdep({ "magick" }),
        opts = {
            backend = "kitty",
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = true,
                    download_remote_images = true,
                    only_render_image_at_cursor = true,
                    filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
                },
                neorg = {
                    enabled = true,
                    clear_in_insert_mode = true,
                    download_remote_images = true,
                    only_render_image_at_cursor = true,
                    filetypes = { "norg" },
                },
                html = {
                    enabled = true,
                    clear_in_insert_mode = true,
                    download_remote_images = true,
                    only_render_image_at_cursor = true,
                },
                css = {
                    enabled = true,
                    clear_in_insert_mode = true,
                    download_remote_images = true,
                    only_render_image_at_cursor = true,
                },
            },
            max_width = nil,
            max_height = nil,
            max_width_window_percentage = nil,
            max_height_window_percentage = 25,
            window_overlap_clear_enabled = false,                                              -- toggles images when windows are overlapped
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
            editor_only_render_when_focused = true,                                            -- auto show/hide images when the editor gains/looses focus
            tmux_show_only_in_active_window = false,                                           -- auto show/hide images in the correct Tmux window (needs visual-activity off)
            hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.gif" }, -- render image files as images when opened
        }
    },
    -- Git wrapper [ :Git ]
    {
        "tpope/vim-fugitive",
        cond = sysdep({ "git" }),
    },

    -- Preview markdown [ \vm ]
    {
        "ellisonleao/glow.nvim",
        cmd = "Glow",
        event = "VimEnter",
        cond = sysdep({ "glow" }),
        opts = {
            style = "~/.config/nvim/res/gruvbox.json",
            border = 'solid',
            width = 160,
            height = 100,
            width_ratio = 0.8,
            height_ratio = 0.8,
            pager = false,
        },
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
    -- {
    --     'Lokaltog/neoranger',
    --     keys = {
    --         { "-", "<cmd>RangerCurrentFile<cr>", desc = "Opens ranger", mode = "n" }
    --     },
    -- }
}
