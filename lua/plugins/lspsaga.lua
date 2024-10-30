return {
    -- TODO: replace
    {
        'nvimdev/lspsaga.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter', -- optional
            'nvim-tree/nvim-web-devicons',     -- optional
        },
        config = function()
            local borders = {
                { "┌", "FloatBorder" },
                { " ", "FloatBorder" },
                { "┐", "FloatBorder" },
                { " ", "FloatBorder" },
                { "┘", "FloatBorder" },
                { " ", "FloatBorder" },
                { "└", "FloatBorder" },
                { " ", "FloatBorder" },
            }

            local lspsaga = import 'lspsaga'
            lspsaga.setup({
                ui = {
                    border = borders,
                    winblend = 0,
                    -- code_action = '',
                    code_action = '?',
                    actionfix = '!',
                    hover = '>',
                    imp_sign = '$',
                    expand = '#',
                    collapse = '~',
                    title = false,
                    devicon = false,
                    -- icons in finder
                    kind = {}
                },
                hover = {
                    open_browser = '!qute'
                },
                symbol_in_winbar = {
                    enable = false,
                },
                implement = {
                    virtual_text = false,
                },
                diagnostic = {
                    diagnostic_only_current = false,
                },
            })

            -- disable default vim diagnostics
            vim.diagnostic.config({
                virtual_text = false,
                signs = false,
                ---@diagnostic disable-next-line: assign-type-mismatch
                float = { border = borders },
                underline = {
                    severity = {
                        vim.diagnostic.severity.ERROR,
                        vim.diagnostic.severity.WARN,
                        vim.diagnostic.severity.HINT,
                        vim.diagnostic.severity.INFO,
                    },
                },
                update_in_insert = true,
            })
        end,
        event = "VimEnter",
        keys = {

            { '<C-s>',      "<cmd>Lspsaga hover_doc<cr>",                               mode = "n", desc = "Shows signature help" },
            { '<C-s>',      vim.lsp.buf.signature_help,                                 mode = 'i', desc = "Shows signature help" },

            { 'K',          "<cmd>Lspsaga hover_doc<cr>",                               mode = "n", desc = "Shows signature help" },

            { "<leader>ca", "<cmd>Lspsaga code_action<cr>",                             mode = "n", desc = "Shows available [C]ode [A]ctions" },
            { "<leader>d",  "<cmd>Lspsaga show_line_diagnostics<cr>",                   mode = "n", desc = "Shows [D]iagnostics for line" },

            { "<leader>gD", "<cmd>Lspsaga peek_definition<cr>",                         mode = "n", desc = "Peek [G]o [D]efinition" },
            { "<leader>gd", vim.lsp.buf.definition,                                     mode = "n", desc = "[G]o to [D]efinition" },
            { "<leader>gi", vim.lsp.buf.implementation,                                 mode = "n", desc = "[G]o to [I]mplementation" },
            { "<leader>gr", vim.lsp.buf.references,                                     mode = "n", desc = "[G]o to [R]eferences" },

            { "<leader>fT", "<cmd>Lspsaga outline<cr>",                                 mode = "n", desc = "[F]ile [T]ags (outline)" },
            { "<leader>tt", "<cmd>Lspsaga term_toggle<cr>",                             mode = "n", desc = "[T]oggle [T]erminal" },

            { "<leader>D",  "<cmd>Lspsaga show_workspace_diagnostics<cr>",              mode = "n", desc = "Shows workspace [D]iagnostics" },

            { "]d",         function() vim.diagnostic.goto_next({ float = false }) end, mode = "n", desc = "Next [D]iagnostics" },
            { "[d",         function() vim.diagnostic.goto_prev({ float = false }) end, mode = "n", desc = "Prev [D]iagnostics" },
        }
    }
}
