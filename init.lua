local load = require("utils.loader")

vim.g.mapleader = ";"

load('config.options')
load('config.filetypes')
load('config.keymap')
load('config.autocmd')
load('config.commands')
load('config.lazy')

-- persistent colorscheme
require('utils.fzf').source_colorscheme()

-- :GetMissingDeps command to get list of
-- binaries that are needed on system
require('utils.sysdep-man').init_command()

-- code::stats plugin
load('utils.codestats.loader')

