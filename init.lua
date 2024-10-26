local load = require("module").load

vim.g.vim_distro = "monolith.nvim"
vim.g.mapleader = ";"

load('config.options')
load('config.filetypes')
load('config.keymap')
load('config.autocmd')
load('config.commands')
load('config.lazy')

-- persistent colorscheme
require('utils.fzf').source_colorscheme()

-- :DepsMissing command to get list of
-- binaries that are needed on system
require('utils.sysdep-man').init_command()

-- improve cmdheight=0
require('utils.messages').override_messages();

-- code::stats plugin
load('utils.codestats.loader')

-- todo
-- check yukimemi/dvpm

