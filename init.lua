require("lib.glb")

vim.g.vim_distro     = "monolith.nvim"
vim.g.mapleader      = ";"
vim.g.maplocalleader = ","

-- options and local plugins
include "opt.opt"
include "lib.col"
include "lib.sdp"

-- load after because of big slowdown
include "opt.key"

include "plf.lzy"

-- plugins and pluin accessories
include "aft.src"

-- todo
-- check yukimemi/dvpm

