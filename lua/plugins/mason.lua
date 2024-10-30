---@diagnostic disable: missing-fields
local sysdep = import "utils.sysdep".sysdep
local optdep = import "utils.sysdep".optdep
return {
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
            'hrsh7th/nvim-cmp',
            'tamago324/nlsp-settings.nvim'
        },
        config = function()
            local mason        = import "mason"
            local masonconf    = import 'mason-lspconfig'
            local lspconfig    = import 'lspconfig'
            local nlspsettings = import "nlspsettings"
            local cmp_lsp      = import 'cmp_nvim_lsp'

            mason.setup({})

            -- LINK: https://github.com/tamago324/nlsp-settings.nvim/tree/main/schemas/_generated
            nlspsettings.setup({
                config_home = vim.fn.stdpath('config') .. '/lspconf',
                local_settings_dir = ".lspconf",
                local_settings_root_markers_fallback = { '.git' },
                append_default_schemas = true,
                loader = 'json'
            })

            local function on_attach(client, bufnr)
                vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })
            end

            local global_capabilities = vim.lsp.protocol.make_client_capabilities()
            global_capabilities.textDocument.completion.completionItem.snippetSupport = true
            lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
                capabilities = global_capabilities,
            })

            local vscodecap = { capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()), }

            if optdep({ "dart" })          then lspconfig.dartls.setup({})        end
            if optdep({ "glsl_analyzer" }) then lspconfig.glsl_analyzer.setup({}) end

            local function gen_default_capabilities() cmp_lsp.default_capabilities() end

            -- https://github.com/williamboman/mason-lspconfig.nvim#automatic-server-setup-advanced-feature
            masonconf.setup({
                ensure_installed = { 'lua_ls', 'jsonls', 'serve_d', 'marksman', 'cmake', 'clangd', 'bashls', 'vimls', },
                automatic_installation = true,
                handlers = {
                    function(server_name)
                        lspconfig[server_name].setup({ on_attach = on_attach, capabilities = gen_default_capabilities() })
                    end,
                    ['serve_d'] = function()
                        lspconfig.serve_d.setup({
                            capabilities = gen_default_capabilities(),
                            on_attach = function(client) client.server_capabilities.documentFormattingProvider = false end,
                        })
                    end,
                    ['cssls']  = function() lspconfig.cssls.setup(vscodecap) end,
                    ['html']   = function() lspconfig.html.setup(vscodecap) end,
                    ['jsonls'] = function() lspconfig.jsonls.setup(vscodecap) end,
                    ['lua_ls'] = function()
                        if sysdep({ "lua-language-server" }) then
                            lspconfig.lua_ls.setup({ capabilities = gen_default_capabilities() })
                        end
                    end,
                }
            })

            -- DISABLE marksman
            vim.api.nvim_create_autocmd(
                { "BufNewFile", "BufRead", "BufReadPost" },
                { pattern = { "*.md" }, callback = function(opt) vim.diagnostic.enable(false, { bufnr = opt.buf }) end }
            )
        end
    }
}
