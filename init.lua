local load = require("utils.loader")

vim.loader.enable()
vim.g.mapleader = ";"

load('config.options')
load('config.filetypes')
load('config.theme')
load('config.keymap')
load('config.autocmd')
load('config.commands')
load('config.lazy')

load('utils.codestats.loader')

