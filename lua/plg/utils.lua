---@diagnostic disable: unused-local
local sysdep  = require("lib.sdp").sysdep
local noremap = require("lib.map").noremap
local borders = require("lib.bor")

return {
    -- Move lines and characters [ A-Up A-Down ]
    {
        'fedepujol/move.nvim',
        config = true,
        event = "VimEnter",
        keys = {
            { "<A-up>",    "<esc><cmd>MoveLine(-1)<cr>i", mode = "i", noremap = true, silent = true, desc = "Swaps current line with line above" },
            { "<A-down>",  "<esc><cmd>MoveLine(1)<cr>i",  mode = "i", noremap = true, silent = true, desc = "Swaps current line with line below" },
            { "<A-k>",     "<esc><cmd>MoveLine(-1)<cr>i", mode = "i", noremap = true, silent = true, desc = "Swaps current line with line above" },
            { "<A-j>",     "<esc><cmd>MoveLine(1)<cr>i",  mode = "i", noremap = true, silent = true, desc = "Swaps current line with line below" },

            -- for some reason <cmd> breaks it, probably because '<,'>
            { "<A-up>",    ":MoveBlock(-1)<cr>",          mode = "v", noremap = true, silent = true, desc = "Moves visual block up" },
            { "<A-down>",  ":MoveBlock(1)<cr>",           mode = "v", noremap = true, silent = true, desc = "Moves visual block down" },
            { "<A-right>", ":MoveHBlock(1)<cr>",          mode = "v", noremap = true, silent = true, desc = "Moves visual block right" },
            { "<A-left>",  ":MoveHBlock(-1)<cr>",         mode = "v", noremap = true, silent = true, desc = "Moves visual block left" },
            { "<A-k>",     ":MoveBlock(-1)<cr>",          mode = "v", noremap = true, silent = true, desc = "Moves visual block up" },
            { "<A-j>",     ":MoveBlock(1)<cr>",           mode = "v", noremap = true, silent = true, desc = "Moves visual block down" },
            { "<A-l>",     ":MoveHBlock(1)<cr>",          mode = "v", noremap = true, silent = true, desc = "Moves visual block right" },
            { "<A-h>",     ":MoveHBlock(-1)<cr>",         mode = "v", noremap = true, silent = true, desc = "Moves visual block left" },
        }
    },
    -- Session manager [ :SessionsLoad :SessionsSave ]
    {
        'natecraddock/sessions.nvim',
        opts = {
            events = { "VimLeavePre" },
            session_filepath = vim.fn.stdpath("data") .. "/sessions",
            absolute = true,
        },
        event = "VimEnter",
        keys = {
            { "<leader>SS", "<cmd>SessionsSave<cr>", mode = "n", noremap = true, silent = true, desc = "[S]ession [S]save" },
            { "<leader>SL", "<cmd>SessionsLoad<cr>", mode = "n", noremap = true, silent = true, desc = "[S]ession [L]oad" },
        }
    },
    -- better macros
    {
        "chrisgrieser/nvim-recorder",
        dependencies = { "rcarriga/nvim-notify" },
        opts = {
            slots = { "a", "b" },
            mapping = {
                startStopRecording = "q",
                playMacro = "Q",
                switchSlot = "<C-q>",
                editMacro = "cq",
                deleteAllMacros = "dq",
                yankMacro = "yq",
                addBreakPoint = "##",
            },
            clear = false,
            logLevel = vim.log.levels.DEBUG,
            lessNotifications = true,
            useNerdfontIcons = false,
            performanceOpts = {
                countThreshold = 100,
                lazyredraw = false,        -- enable lazyredraw (see `:h lazyredraw`)
                noSystemClipboard = false, -- remove `+`/`*` from clipboard option
                autocmdEventsIgnore = {    -- temporarily ignore these autocmd events
                },
            },
            dapSharedKeymaps = false,
        }
    },
    {
        "selectnull/plugin-readme.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            local readme = require "plugin-readme"
            vim.keymap.set("n", "<leader>pr", readme.select_plugin, { desc = "[P]lugin [R]eadme" })
        end,
    },
    {
        "ezechukwu69/tui.nvim",
        config = function()
            local tui = require("tui")
            local function add_program(name, command)
                tui.setup({
                    name = name,
                    command = command,
                    width_margin = 5,
                    height_margin = 5,
                    border = borders.normal,
                })
            end
            add_program("Ranger", "ranger")
        end,
        event = "VimEnter",
        keys = {
            { "<leader>tr", "<cmd>Ranger<cr>", desc = "[T]ui [R]anger" },
        }
    }
} -- return

