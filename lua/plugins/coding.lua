return {
    -- Auto-close brackets
    {
        "altermo/ultimate-autopair.nvim",
        event = { "InsertEnter", "CmdlineEnter" },
        branch = "v0.6", -- TODO: check later
        config = true,
        enabled = false,
    },
    -- Colour picker and colour background
    {
        "uga-rosa/ccc.nvim",
        event = { "BufEnter", "BufNew" },
        opts = {
            highlighter = {
                auto_enable = true,
                lsp = true
            }
        },
        keys = {
            { "<leader>cp", "<cmd>CccPick<cr>", mode = "n", noremap = true, silent = true, desc = "Opens color picker" },
        },
    },
    -- Highlights trailing whitespaces
    {
        "ntpeters/vim-better-whitespace",
        config = function()
            vim.cmd([[ let g:better_whitespace_operator = "" ]])
        end
    },
    {
        'jakemason/ouroboros',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            extension_preferences_table = {
                c = { h = 2, hpp = 1 },
                h = { c = 2, cpp = 1 },
                cpp = { hpp = 2, h = 1 },
                hpp = { cpp = 2, c = 1 },
            },
            switch_to_open_pane_if_possible = true,
        },
        cmd = "Ouroboros",
        ft = { "c", "cpp" },
        keys = {
            { "<leader>gh", "<cmd>Ouroboros<cr>", mode = "n", noremap = true, silent = true, desc = "Switch to header", ft = { "c", "cpp" } },
        }
    },
    {
        'SCJangra/table-nvim',
        ft = 'markdown',
        opts = {
            padd_column_separators = true, -- Insert a space around column separators.
            mappings = {           -- next and prev work in Normal and Insert mode. All other mappings work in Normal mode.
                next = '<nop>',    -- Go to next cell.
                prev = '<nop>',  -- Go to previous cell.
                insert_row_up = '<nop>', -- Insert a row above the current row.
                insert_row_down = '<nop>', -- Insert a row below the current row.
                move_row_up = '<nop>', -- Move the current row up.
                move_row_down = '<nop>', -- Move the current row down.
                insert_column_left = '<nop>', -- Insert a column to the left of current column.
                insert_column_right = '<nop>', -- Insert a column to the right of current column.
                move_column_left = '<nop>', -- Move the current column to the left.
                move_column_right = '<nop>', -- Move the current column to the right.
                insert_table = '<nop>', -- Insert a new table.
                insert_table_alt = '<nop>', -- Insert a new table that is not surrounded by pipes.
                delete_column = '<nop>', -- Delete the column under cursor.
            }
        }
    }
}
