---@diagnostic disable: unused-local
local sysdep  = require("lib.sdp").sysdep
local noremap = require("lib.map").noremap
local borders = require("lib.bor")

return {
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

