local opts = { noremap = true, silent = true }

local keymap = vim.keymap

keymap.set('v', 'ga', '<Plug>(EasyAlign)', opts)
keymap.set('n', 'ga', '<Plug>(EasyAlign)', opts)

