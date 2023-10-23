local borders = {
      {"┌", "FloatBorder"},
      {" ", "FloatBorder"},
      {"┐", "FloatBorder"},
      {" ", "FloatBorder"},
      {"┘", "FloatBorder"},
      {" ", "FloatBorder"},
      {"└", "FloatBorder"},
      {" ", "FloatBorder"},
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

local opts = { noremap = true, silent = true }

local keymap = vim.keymap

keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
keymap.set("n", "gD", "<cmd>Lspsaga peek_definition<cr>", opts)

keymap.set("n", "<A-s>", "<cmd>Lspsaga hover_doc<cr>", opts)
keymap.set("i", "<A-s>", "<cmd>Lspsaga hover_doc<cr>", opts)
keymap.set("n", "<A-d>", "<cmd>Lspsaga peek_definition<cr>", opts)
keymap.set("i", "<A-d>", "<cmd>Lspsaga peek_definition<cr>", opts)
keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, opts)

keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", opts)
keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)

keymap.set("n", "gd", vim.lsp.buf.definition, opts)
keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
keymap.set("n", "gr", vim.lsp.buf.references, opts)



