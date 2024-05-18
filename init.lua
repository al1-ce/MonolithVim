local load = require("utils.loader")

vim.loader.enable()

load('config.options')
load('config.filetypes')
load('config.lazy')
load('config.keymap')
load('config.autocmd')
load('config.theme')

load('utils.codestats.loader')

