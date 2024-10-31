local noremap = require("map").noremap
return {
    -- Alisgn text [ glip= ]
    {
        'tommcdo/vim-lion',
        config = function()
            vim.g.lion_create_map = 1
            vim.g.lion_squeeze_spaces = 1
        end
    },
    {
        'ggandor/leap.nvim',
        enabled = true,
        config = function()
            local leap = require("leap")
            leap.opts.safe_labels = ''
            leap.opts.labels = 'asdghklqwertyuiopzxcvbnmfj;'
            noremap("n", "s", "<Plug>(leap)", { desc = "Leap" })
            noremap("n", "S", "<Plug>(leap-from-window)", { desc = "Leap to other window" })
        end,
    },
    -- cool smart surrounding cs ys ds
    {
        -- 'tpope/vim-surround',
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = true
    },

}
