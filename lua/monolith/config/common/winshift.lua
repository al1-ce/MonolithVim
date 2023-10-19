require("winshift").setup({
    keymaps = {
        disable_defaults = false,
    }
})

local opts = { noremap = true, silent = true }

local keymap = vim.keymap

-- moving panes
keymap.set("n", "<A-S-left>", "<cmd>WinShift left<cr>", opts)
keymap.set("n", "<A-S-down>", "<cmd>WinShift down<cr>", opts)
keymap.set("n", "<A-S-up>", "<cmd>WinShift up<cr>", opts)
keymap.set("n", "<A-S-right>", "<cmd>WinShift right<cr>", opts)

