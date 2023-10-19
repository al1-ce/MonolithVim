local opts = { noremap = true, silent = true }

local keymap = vim.keymap

keymap.set('i', '<A-up>', '<Esc><cmd>MoveLine(-1)<CR>i', opts)
keymap.set('i', '<A-down>', '<Esc><cmd>MoveLine(1)<CR>i', opts)

keymap.set('v', '<A-up>', ":MoveBlock(-1)<CR>", opts)
keymap.set('v', '<A-down>', ":MoveBlock(1)<CR>", opts)
keymap.set('v', '<A-right>', ":MoveHBlock(1)<CR>", opts)
keymap.set('v', '<A-left>', ":MoveHBlock(-1)<CR>", opts)

