require("setglobals")

vim.g.vim_distro     = "monolith.nvim"
vim.g.mapleader      = ";"
vim.g.maplocalleader = ","


-- options and local plugins
include "config/options"
include "config/autocmd"
include "config/setup"

-- load after because of big slowdown
include "config/lazy"
include "config/keymap"

-- some methods that are missing in lua
include "jsfunc"

-- plugins and pluin accessories
include "after/load"

-- so that all overrides are loaded
include "config/filetypes"
include "config/commands"

-- todo
-- check yukimemi/dvpm

