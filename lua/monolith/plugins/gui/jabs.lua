require("jabs").setup({
    keymap = {
        close = "d", -- Close buffer. Default D
        jump = "<cr>", -- Jump to buffer. Default <cr>
        h_split = "s", -- Horizontally split buffer. Default s
        v_split = "v", -- Vertically split buffer. Default v
        preview = "p", -- Open buffer preview. Default P
    },

    border = "none",
    -- border = { "┌", " ", "┐", " ", "┘", " ", "└", " " },
    relative = "cursor",
    position = {'right', 'bottom'},

    preview = {
        -- border = 'none'
        border = { "┌", " ", "┐", " ", "┘", " ", "└", " " },
    }
})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>b", "<cmd>JABSOpen<cr>", opts)

