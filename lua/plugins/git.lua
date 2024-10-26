local noremap = require("map").noremap
local sysdep = require("utils.sysdep")

return {
    {
        'sindrets/diffview.nvim',
        cond = sysdep({ "git" }),
    },
    {
        'akinsho/git-conflict.nvim',
        version = "*",
        opts = {
            default_mappings = false,    -- disable buffer local mapping created by this plugin
            default_commands = true,     -- disable commands created by this plugin
            disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
            list_opener = 'copen',       -- command or function to open the conflicts list
            highlights = {               -- They must have background color, otherwise the default color will be used
                incoming = 'DiffAdd',
                current = 'DiffText',
            }
        },
    },
    {
        'SuperBo/fugit2.nvim',
        enabled = false,
        opts = {
            width = 70,
        },
        dependencies = {
            'MunifTanjim/nui.nvim',
            'nvim-tree/nvim-web-devicons',
            'nvim-lua/plenary.nvim',
            {
                'chrisgrieser/nvim-tinygit', -- optional: for Github PR view
                dependencies = { 'stevearc/dressing.nvim' }
            },
        },
        cmd = { 'Fugit2', 'Fugit2Diff', 'Fugit2Graph' },
    },
    {
        "moyiz/git-dev.nvim",
        cond = sysdep({ "git" }),
        event = "VeryLazy",
        opts = {},
    },
    {
        "NeogitOrg/neogit",
        cond = sysdep({ "git" }),
        opts = {},
    },
    {
        "chrisgrieser/nvim-tinygit",
        enabled = false,
        dependencies = {
            "stevearc/dressing.nvim",
            "nvim-telescope/telescope.nvim", -- optional, but recommended
            "rcarriga/nvim-notify",          -- optional, but recommended
        },
    },
    -- Lazy nvim
    {
        -- '2kabhishek/octohub.nvim',
        dir = "/g/al1-ce/octohub.nvim",
        -- event = "VimEnter",
        cmd = {
            'OctoRepos',
            'OctoRepo',
            'OctoStats',
            'OctoActivityStats',
            'OctoContributionStats',
            'OctoRepoStats',
            'OctoProfile',
            'OctoRepoWeb',
        },
        dependencies = {
            '2kabhishek/utils.nvim',
            'nvim-telescope/telescope.nvim'
        },
        config = {
            contrib_icons = { '', '', '', '', '', '', '' }, -- Icons for different contribution levels
            projects_dir = '/g', -- Directory where repositories are cloned
            per_user_dir = true, -- Create a directory for each user
            add_default_keybindings = false, -- Add default keybindings for the plugin
        },
    },
}

