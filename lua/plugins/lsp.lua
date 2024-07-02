local sysdep = require("utils.sysdep")
return {
    -- lsp but formatting
    {
        'nvimtools/none-ls.nvim',
        dependencies = { "nvim-lua/plenary.nvim" },
        cond = sysdep({ "dfmt" }),
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
                ---@diagnostic disable-next-line: assign-type-mismatch
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
        end,
        event = "VimEnter",
        keys = {

            { '<C-s>',      "<cmd>Lspsaga hover_doc<cr>",                  mode = "n", desc = "Shows signature help" },
            { '<C-s>',      vim.lsp.buf.signature_help,                    mode = 'i', desc = "Shows signature help" },

            { 'K',          "<cmd>Lspsaga hover_doc<cr>",                  mode = "n", desc = "Shows signature help" },

            { "<leader>ca", "<cmd>Lspsaga code_action<cr>",                mode = "n", desc = "Shows available [C]ode [A]ctions" },
            { "<leader>d",  "<cmd>Lspsaga show_line_diagnostics<cr>",      mode = "n", desc = "Shows [D]iagnostics for line" },

            { "<leader>gD", "<cmd>Lspsaga peek_definition<cr>",            mode = "n", desc = "Peek [G]o [D]efinition" },
            { "<leader>gd", vim.lsp.buf.definition,                        mode = "n", desc = "[G]o to [D]efinition" },
            { "<leader>gi", vim.lsp.buf.implementation,                    mode = "n", desc = "[G]o to [I]mplementation" },
            { "<leader>gr", vim.lsp.buf.references,                        mode = "n", desc = "[G]o to [R]eferences" },

            { "<leader>fT", "<cmd>Lspsaga outline<cr>",                    mode = "n", desc = "[F]ile [T]ags (outline)" },
            { "<leader>tt", "<cmd>Lspsaga term_toggle<cr>",                mode = "n", desc = "[T]oggle [T]erminal" },

            { "<leader>D",  "<cmd>Lspsaga show_workspace_diagnostics<cr>", mode = "n", desc = "Shows workspace [D]iagnostics" },

            { "]d",         vim.diagnostic.goto_next,                      mode = "n", desc = "Next [D]iagnostics" },
            { "[d",         vim.diagnostic.goto_prev,                      mode = "n", desc = "Prev [D]iagnostics" },
        }
    },
    -- parser
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        cond = sysdep({ "tree-sitter", "node", "git", "cc" }),
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require('nvim-treesitter.configs').setup {
                -- A list of parser names, or 'all'
                ensure_installed = { 'c', 'lua', 'markdown', 'markdown_inline', 'regex', 'bash', 'vim' },
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
    {
        'williamboman/mason.nvim',
        cond = sysdep({ "git", "curl", "unzip", "tar", "gzip" }),
        event = "VimEnter",
        keys = {
            { "<leader>pm", "<cmd>Mason<cr>", mode = "n", noremap = true, silent = true, desc = "[P]lugin [M]ason" },
        },
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'hrsh7th/nvim-cmp',
        },
        config = function()
            require("mason").setup({})

            local masonconf = require('mason-lspconfig')
            local lspconfig = require('lspconfig')

            local vscodecap = {
                capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
            }

            if sysdep({ "dart" }) then lspconfig.dartls.setup({}) end
            if sysdep({ "glsl_analyzer" }) then lspconfig.glsl_analyzer.setup({}) end

            local function gen_default_capabilities() require("cmp_nvim_lsp").default_capabilities() end

            -- https://github.com/williamboman/mason-lspconfig.nvim#automatic-server-setup-advanced-feature
            masonconf.setup({
                ensure_installed = {
                    'lua_ls',
                    'jsonls',
                    'serve_d',
                    'vtsls',
                    'marksman',
                    'cmake',
                    'clangd',
                    'bashls',
                },
                automatic_installation = true,
                handlers = {
                    function(server_name) lspconfig[server_name].setup({ capabilities = gen_default_capabilities() }) end,
                    ['serve_d'] = function()
                        lspconfig.serve_d.setup({
                            -- disable default formatting (see none-ls config)
                            capabilities = gen_default_capabilities(),
                            on_attach = function(client) client.server_capabilities.documentFormattingProvider = false end,
                        })
                    end,
                    ['cssls'] = function() lspconfig.cssls.setup(vscodecap) end,
                    ['html'] = function() lspconfig.html.setup(vscodecap) end,
                    ['jsonls'] = function() lspconfig.jsonls.setup(vscodecap) end,
                    ['lua_ls'] = function()
                        if sysdep({ "lua-language-server" }) then
                            lspconfig.lua_ls.setup({ capabilities = gen_default_capabilities() })
                        end
                    end
                }
            })

            -- DISABLE marksman
            vim.api.nvim_create_autocmd(
                { "BufNewFile", "BufRead", "BufReadPost" },
                { pattern = { "*.md" }, callback = function(opt) vim.diagnostic.enable(false, { bufnr = opt.buf }) end }
            )
        end
    },
    {
        "al1-ce/garbage-day.nvim",
        -- dir = "/g/garbage-day.nvim",
        dependencies = "neovim/nvim-lspconfig",
        event = "VeryLazy",
        opts = {
            notifications = true,
            grace_period = 60 * 15,
            aggresive_mode = false,
            notification_engine = "fidget",
            excluded_lsp_clients = {
                "null-ls", "jdtls", "marksman", "dartls"
            }
        }
    },
    {
        "z0mbix/vim-shfmt",
        filetypes = { "sh" },
        enabled = sysdep({ "shfmt" })
    }
}
