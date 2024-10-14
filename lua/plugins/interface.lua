local sysdep = require("utils.sysdep")
return {
    -- lsp progressbar
    {
        'j-hui/fidget.nvim',
        opts = {
            notification = {
                window = {
                    winblend = 0
                },
            }
        }
    },
    -- notification engine
    {
        'rcarriga/nvim-notify',
        opts = {
            background_color = 'Normal',
            stages = 'slide',

            on_open = function(win)
                vim.api.nvim_win_set_config(win, { border = "single" })
            end,
            render = "wrapped-compact",
            minimum_width = 0,
            level = 2,
            -- require("notify")("My super important message", "warn", {title="Title"})
        }
    },
    -- override input handling (makes input pop up sometimes...)
    {
        'stevearc/dressing.nvim',
        opts = {
            input = {
                enabled = true,
            },
            select = {
                enabled = true,
                backend = { "nui", "fzf_lua", "telescope", "builtin" }
            },
        }
    },
    -- Better quickfix
    -- { 'yorickpeterse/nvim-pqf', commit = "b2f1882" },
    {
        'yorickpeterse/nvim-pqf',
        enabled = true,
        config = function()
            require('pqf').setup({
                signs = {
                    error = { text = '', hl = "DiagnosticSignError" },
                    warning = { text = '', hl = "DiagnosticSignWarn" },
                    info = { text = '', hl = "DiagnosticSignInfo" },
                    hint = { text = '', hl = "DiagnosticSignHint" } -- note
                },
                show_multiple_lines = true,
                max_filename_length = 0,
            })

            -------------------- Quickfix --------------------------------------

            -- LINK: https://reviewdog.github.io/errorformat-playground/
            -- Clean because of %- error
            vim.opt.errorformat = {}
            -- D (dub)
            -- Errors form -verrors=specs (ignored)
            vim.opt.errorformat:append("%-G(spec:%*[0-9]) %m")
            -- Uncaught exceptions (e.g. from unit tests)
            vim.opt.errorformat:append("%*[^@]@%f(%l): %m")
            -- Errors in string mixins
            vim.opt.errorformat:append("%f-mixin-%*[0-9](%l\\,%c): %m")
            vim.opt.errorformat:append("%f-mixin-%*[0-9](%l): %m")
            -- Normal compile errors
            vim.opt.errorformat:append("%f(%l\\,%c): %t%*[^:]: %m")
            vim.opt.errorformat:append("%f(%l): %t%*[^:]: %m")
            vim.opt.errorformat:append("%E%f:%l %m")
            -- C (gcc)
            vim.opt.errorformat:append("%f:%l:%c: %t%*[^:]: %m")
            -- TS
            vim.opt.errorformat:append("%f:%l:%c - %trror TS%n: %m")
            vim.opt.errorformat:append("%f(%l\\,%c) %trror TS%n: %m")
            -- DART
            -- I give up
            -- vim.opt.errorformat:append("%E%f:%l:%c:,%C%trror: %m\\.,%Z%m")
            vim.opt.errorformat:append("%E%f:%l:%c:")
            -- vim.opt.errorformat:append("%E%f:%l:%c:")
            -- vim.opt.errorformat:append("%+CError:\\ %m")
            -- vim.opt.errorformat:append("%+C%m")
            -- vim.opt.errorformat:append("%+Z%*\\s%*\\^")

            -- Most general error there could be
            vim.opt.errorformat:append("%t%*[^:]: %m")
            -- sily.logger log format

            -- some nodejs
            vim.opt.errorformat:append("\\[%l:%c\\] %m")
        end
    },
    {
        "rachartier/tiny-devicons-auto-colors.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        event = "VeryLazy",
        config = function()
            require('tiny-devicons-auto-colors').setup({
                factors = {
                    lightness = 1.35, -- 1.75
                    chroma = 1,       -- 1
                    hue = 1.25,       -- 1.25
                },
                autoreload = false,
            })
        end
    },
    {
        "lukas-reineke/headlines.nvim",
        dependencies = "nvim-treesitter/nvim-treesitter",
        opts = {
            markdown = { fat_headlines = false, },
            rmd = { fat_headlines = false, },
            norg = { fat_headlines = false, },
            org = { fat_headlines = false, },
        }
    },
    -- mode indicator in cursorline
    {
        'mawkler/modicator.nvim',
        init = function()
            vim.o.cursorline = true
            vim.o.number = true
            vim.o.termguicolors = true
        end,
        opts = {
            show_warnings = false,
            integration = {
                lualine = {
                    enabled = true,
                    mode_section = "a",
                    highlight = "bg"
                }
            }
        },
        event = "VimEnter"
    },
    {
        'tummetott/reticle.nvim',
        event = 'VeryLazy', -- optionally lazy load the plugin
        opts = {
            on_startup = { cursorline = true, cursorcolumn = false },
            disable_in_insert = false,
            disable_in_diff = true,
            always_highlight_number = true,
        },
    },
}
