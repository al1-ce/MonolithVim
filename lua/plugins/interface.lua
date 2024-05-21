local sysdep = require("utils.sysdep")
return {
    -- scrollbar
    {
        'petertriho/nvim-scrollbar',
        dependencies = {
            'lewis6991/gitsigns.nvim',
        },
        config = function()
            require('gitsigns').setup({
                signcolumn = true
            })

            -- require('hlslens').setup()

            require("scrollbar").setup({
                marks = {
                    Cursor = { color = '#504945', text = '█' },
                    Search = { color = '#FABD2F' },
                    Error = { color = '#FB4934' },
                    Warn = { color = '#D65D0E' },
                    Info = { color = '#458599' },
                    Hint = { color = '#689D6A' },
                    Misc = { color = '#B16286' },
                    GitAdd = { color = '#B8BB26', text = '│' },
                    GitChange = { color = '#D79921', text = '│' },
                    GitDelete = { color = '#CC241D', text = '│' },
                },
                excluded_filetypes = {
                    "dashboard", "alpha"
                }
            })

            -- require("scrollbar.handlers.search").setup({})
            require("scrollbar.handlers.gitsigns").setup()
        end
    },
    -- remove background
    'tribela/vim-transparent',
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
    -- Emacs menus [ \ ]
    {
        'anuvyklack/hydra.nvim',
        config = function()
            require("plugins.hydra.root")
        end
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
    -- [WIP] An implementation of the Popup API from vim in Neovim
    {
        'nvim-lua/popup.nvim',
        dependencies = { "nvim-lua/plenary.nvim" },
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
                backend = {
                    "nui", "fzf_lua", "telescope",
                    "builtin"
                }
            },
        }
    },
    -- Command suggestions [ : ]
    {
        'gelguy/wilder.nvim',
        build = ":UpdateRemotePlugins",
        cond = sysdep({ "python" }),
        config = function()
            local wilder = require('wilder')
            wilder.setup({ modes = { ':', '/', '?' } })

            wilder.set_option('pipeline', {
                wilder.branch(
                    wilder.cmdline_pipeline({
                        fuzzy = 0,
                        set_pcre2_pattern = 1,
                        language = "python"
                    }),
                    wilder.search_pipeline({
                        pattern = wilder.python_fuzzy_pattern(),
                        sorter = wilder.python_difflib_sorter(),
                        engine = 're',
                    })
                )
            })

            wilder.set_option('renderer', wilder.wildmenu_renderer({
                -- highlighter applies highlighting to the candidates
                highlighter = wilder.basic_highlighter(),
            }))
        end
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
        end
    },
}
