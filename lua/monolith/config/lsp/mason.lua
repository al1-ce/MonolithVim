require("mason").setup()
require("mason-lspconfig").setup({
    'lua_ls',
    'jsonls',
    'serve_d',
    'codelldb'
})
require("mason-null-ls").setup({})
require('mason-nvim-dap').setup({ automatic_setup = true })

