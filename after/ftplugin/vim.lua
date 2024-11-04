local bufnoremap = require("lib.map").bufnoremap
local remap      = require("lib.map").remap

bufnoremap("n", "<leader>xf", "<cmd>w<cr><cmd>source %<cr>", { desc = "E[X]ecute [F]ile" })

