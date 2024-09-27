local bufnoremap = require("utils.bufnoremap")
local remap = require("utils.remap")

bufnoremap("n", "<leader>xf", "<cmd>w<cr><cmd>source %<cr>", { desc = "E[X]ecute [L]ua" })
bufnoremap("n", "<leader>xc", "V:lua<cr>", { desc = "E[X]ecute Lua" })
bufnoremap("x", "<leader>xc", ":lua<cr>", { desc = "E[X]ecute Lua" })

