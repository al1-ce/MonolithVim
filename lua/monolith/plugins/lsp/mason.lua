require("mason").setup()

-- https://github.com/williamboman/mason-lspconfig.nvim#automatic-server-setup-advanced-feature
require("mason-lspconfig").setup({
    ensure_installed = {
        'lua_ls',
        'jsonls',
        'serve_d',
        'tsserver',
        'pyright',
        'marksman',
        'jsonls',
        'cmake',
        'clangd',
        'bashls',
    },
    automatic_installation = true
})
-- require("mason-null-ls").setup({})
---@diagnostic disable-next-line: missing-fields
require('mason-nvim-dap').setup({ automatic_setup = true })

local masonconf = require('mason-lspconfig')
local lspconf = require('lspconfig')

masonconf.setup_handlers({
    function(server_name)
        lspconf[server_name].setup({
        })
    end,
    ['serve_d'] = function ()
        lspconf.serve_d.setup({
            -- disable default formatting
            capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
            on_attach = function(client)
                client.server_capabilities.documentFormattingProvider = false
            end,
        })
    end,
    -- ['jsonls'] = function ()
    --     lspconf.jsonls.setup {
    --         settings = {
    --             json = {
    --                 schemas = require('schemastore').json.schemas(),
    --                 validate = { enable = true },
    --             },
    --         },
    --     }
    -- end,
})

