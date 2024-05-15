local noremap = require("utils.noremap")

return {
    -- Configs for the Nvim LSP client (:help lsp)
    {
        'neovim/nvim-lspconfig',
        config = function()
            local lspconfig = require('lspconfig')

            lspconfig.lua_ls.setup({})
            lspconfig.glsl_analyzer.setup({})

            lspconfig.dartls.setup({})
        end
    },
    -- lsp but formatting
    {
        'nvimtools/none-ls.nvim',
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("null-ls").setup({
                -- debug = true,
                sources = {
                    require("null-ls").builtins.formatting.dfmt.with({
                        -- cmd = "dfmt",
                        extra_args = {
                            '--brace_style', 'otbs',
                            '--align_switch_statements', 'true',
                            '--compact_labeled_statements', 'true',
                            '--keep_line_breaks', 'true',
                            '--indent_style', 'space',
                            '--indent_size', '4',
                            '--soft_max_line_length', '80',
                            '$FILENAME'
                        },
                        filetypes = { "d", 'dub', 'rdmd' },
                    }),
                    require("null-ls").builtins.formatting.stylelint
                },
                -- on_attach = on_attach_null_ls
            })
        end
    },
    -- many cool features like hover diagnostic
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

            require('lspsaga').setup({
                ui = {
                    border = borders,
                    winblend = 0,
                    -- code_action = '',
                    code_action = '?',
                    actionfix = '!',
                    hover = '>',
                    -- icons in finder
                    kind = {}
                },
                hover = {
                    open_browser = '!qute'
                },
                symbol_in_winbar = {
                    enable = false
                }
            })

            vim.diagnostic.config({
                virtual_text = false,
                signs = true,
                float = { border = borders },
                underline = true,
                update_in_insert = true,
            })

            vim.api.nvim_create_autocmd("CursorHold", {
                buffer = 0,
                callback = function()
                    local opts = {
                        focusable = false,
                        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                        border = borders,
                        source = 'always',
                        prefix = ' ',
                        scope = 'cursor',
                    }
                    vim.diagnostic.open_float(nil, opts)
                end
            })

            noremap("n", "K", "<cmd>Lspsaga hover_doc<cr>", {desc = "Shows hover doc for symbol"})
            noremap("n", "gD", "<cmd>Lspsaga peek_definition<cr>", {desc = "Peeks symbol definition"})

            noremap("n", "<A-s>", "<cmd>Lspsaga hover_doc<cr>", {desc = "Shows hover doc for symbol"})
            noremap("i", "<A-s>", "<cmd>Lspsaga hover_doc<cr>", {desc = "Shows hover doc for symbol"})
            noremap("n", "<A-d>", "<cmd>Lspsaga peek_definition<cr>", {desc = "Peeks symbol definition"})
            noremap("i", "<A-d>", "<cmd>Lspsaga peek_definition<cr>", {desc = "Peeks symbol definition"})
            noremap('n', '<C-s>', vim.lsp.buf.signature_help, {desc = "Shows signature help"})
            noremap('i', '<C-s>', vim.lsp.buf.signature_help, {desc = "Shows signature help"})

            noremap("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", {desc = "Shows available code actions"})
            noremap("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<cr>", {desc = "Shows diagnostics for line"})

            noremap("n", "gd", vim.lsp.buf.definition, {desc = "Opens symbol definition in current buffer"})
            noremap("n", "gi", vim.lsp.buf.implementation, {desc = "Opens symbol implementation in current buffer"})
            noremap("n", "gr", vim.lsp.buf.references, {desc = "Opens symbol references in quickfix list"})
        end
    },
    -- Nvim lua api
    {
        'folke/neodev.nvim',
        dependencies = { 'hrsh7th/nvim-cmp' },
        config = true
    },
    -- Show function signature
    {
        'ray-x/lsp_signature.nvim',
        event = "VeryLazy",
        config = {
            bind = true, -- This is mandatory, otherwise border config won't get registered.
            handler_opts = {
                border = {
                    { "┌", "FloatBorder" },
                    { " ", "FloatBorder" },
                    { "┐", "FloatBorder" },
                    { " ", "FloatBorder" },
                    { "┘", "FloatBorder" },
                    { " ", "FloatBorder" },
                    { "└", "FloatBorder" },
                    { " ", "FloatBorder" },
                }
            },
            doc_lines = 0,
            hint_enable = false,
            timer_interval = 100,
            floating_window = false,
        }
    },
    -- parser
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require('nvim-treesitter.configs').setup {
                -- A list of parser names, or 'all'
                ensure_installed = { 'c', 'lua' },
                sync_install = false,
                auto_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = true,
                    -- disable = { "d", 'dub', 'rdmd' },
                },
            }
        end
    },
    -- LSP package manager [ \pm ]
    { 'williamboman/mason.nvim', config = true },
    -- mason integration
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
        },
        config = function()
            -- https://github.com/williamboman/mason-lspconfig.nvim#automatic-server-setup-advanced-feature
            require("mason-lspconfig").setup({
                ensure_installed = {
                    'lua_ls',
                    'jsonls',
                    'serve_d',
                    'tsserver',
                    'marksman',
                    'cmake',
                    'clangd',
                    'bashls',
                },
                automatic_installation = true
            })

            local masonconf = require('mason-lspconfig')
            local lspconf = require('lspconfig')

            masonconf.setup_handlers({
                function(server_name)
                    lspconf[server_name].setup({
                    })
                end,
                ['serve_d'] = function()
                    lspconf.serve_d.setup({
                        -- disable default formatting
                        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol
                            .make_client_capabilities()),
                        on_attach = function(client)
                            client.server_capabilities.documentFormattingProvider = false
                        end,
                    })
                end,
            })

            -- DISABLE marksman
            vim.api.nvim_create_autocmd(
                { "BufNewFile", "BufRead", "BufReadPost" },
                { pattern = { "*.md" }, callback = function(opt) vim.diagnostic.disable(opt.buf) end }
            )
        end
    },

}
