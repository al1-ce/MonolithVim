local borders = require("var.borders")

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
        "rachartier/tiny-devicons-auto-colors.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        event = "VeryLazy",
        config = {
            factors = {
                lightness = 1.35,     -- 1.75
                chroma = 1,           -- 1
                hue = 1.25,           -- 1.25
            },
            autoreload = false,
        }
    },
    {
        "nvim-zh/colorful-winsep.nvim",
        event = { "WinLeave" },
        config = {
                hi = {
                    -- fg = hl.fg,
                    -- bg = hl.bg,
                    link = "Delimiter"
                },
                symbols = borders.winsep,
                only_line_seq = false,
                smooth = false,
            }
    },
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
    }
}
