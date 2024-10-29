local load = require("module").load

vim.g.vim_distro = "monolith.nvim"
vim.g.mapleader = ";"

load('config.options')
load('config.filetypes')
load('config.autocmd')
load('config.commands')
require('utils.colorscheme').source()

-- notify on key override
load('utils.keydup')

-- load after because of big slowdown
load('config.keymap')
load('config.lazy')

-- colorscheme and projects picker
require('utils.fzf').setup()

-- :DepsMissing command to get list of
-- binaries that are needed on system
require('utils.sysdep-man').init_command()

-- improve cmdheight=0
require('utils.messages').override_messages();

-- code::stats plugin
load('utils.codestats.loader')

-- todo
-- check yukimemi/dvpm

