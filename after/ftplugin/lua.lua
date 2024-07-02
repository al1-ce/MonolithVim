local noremap = require("utils.noremap")
local remap = require("utils.remap")

noremap("n", "<leader>xf", "<cmd>w<cr><cmd>source %<cr>", { desc = "E[X]ecute [L]ua" })
noremap("n", "<leader>xc", "V:lua<cr>", { desc = "E[X]ecute Lua" })
noremap("x", "<leader>xc", ":lua<cr>", { desc = "E[X]ecute Lua" })

