local g = vim.g -- global variables

g.EasyMotion_do_mapping = 0 -- Disable default mappings
g.EasyMotion_use_upper = 0
g.EasyMotion_smartcase = 1
g.EasyMotion_use_smartsign_us = 1

local opts = { noremap = true, silent = true }

local keymap = vim.keymap

keymap.set("n", "S", "<Plug>(easymotion-overwin-f)", opts)
keymap.set("n", "s", "<Plug>(easymotion-overwin-f2)", opts)

