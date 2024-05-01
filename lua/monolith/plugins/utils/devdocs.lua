local opts = { noremap = true, silent = true }
local keymap = vim.keymap

keymap.set('n', '<leader>gd', '<cmd>DD<CR>', opts)

