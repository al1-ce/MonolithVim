-- Plugin loading

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({ import = "plugins" })

local noremap = require("utils/noremap")

noremap("n", "<leader>pi", "<cmd>Lazy install<cr>", { desc = "Opens Lazy install" })
noremap("n", "<leader>pc", "<cmd>Lazy clean<cr>", { desc = "Opens Lazy clean" })
noremap("n", "<leader>ps", "<cmd>Lazy sync<cr>", { desc = "Opens Lazy sync" })
noremap("n", "<leader>pu", "<cmd>Lazy update<cr>", { desc = "Opens Lazy update" })
noremap("n", "<leader>pg", "<cmd>Lazy<cr>", { desc = "Opens Lazy install" })

