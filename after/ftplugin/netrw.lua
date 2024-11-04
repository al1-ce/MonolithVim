local bufnoremap = require("lib.map").bufnoremap
local bufremap = require("lib.map").bufremap

-- nr("s", "o")
bufremap("n", ".", "gh")
bufremap("n", "r", "R")
bufremap("n", "x", "D")
bufremap("n", "q", "<C-^>")
bufremap("n", "fi", "qf")
bufremap("n", "<C-cr>", "gn")
bufremap("n", "h", "-")
bufnoremap("n", "o", "<Plug>NetrwOpenFile")
bufnoremap("n", "l", "<Plug>NetrwLocalBrowseCheck")

