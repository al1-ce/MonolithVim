local lspconf = require('lspconfig')

lspconf.sumneko_lua.setup({})

local masonconf = require('mason-lspconfig')

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
    ['jsonls'] = function ()
        lspconf.jsonls.setup {
            settings = {
                json = {
                    schemas = require('schemastore').json.schemas(),
                    validate = { enable = true },
                },
            },
        }
    end
})
