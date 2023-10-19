require('smart-splits').setup({})

local opts = { noremap = true, silent = true }

local keymap = vim.keymap

-- resizing panes
keymap.set("n", "<A-C-left>", function() require('smart-splits').resize_left(2) end, opts)
keymap.set("n", "<A-C-down>", function() require('smart-splits').resize_down(2) end, opts)
keymap.set("n", "<A-C-up>", function() require('smart-splits').resize_up(2) end, opts)
keymap.set("n", "<A-C-right>", function() require('smart-splits').resize_right(2) end, opts)
