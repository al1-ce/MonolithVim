---@diagnostic disable-next-line: missing-fields
require('nvim-treesitter.configs').setup {
    -- A list of parser names, or 'all'
    ensure_installed = { 'c', 'lua', 'org' },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
        -- disable = { "d", 'dub', 'rdmd' },
    },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.d = {
    install_info = {
        url = "https://github.com/gdamore/tree-sitter-d", -- local path or git repo
        files = { "src/parser.c", "src/scanner.c" },  -- note that some parsers also require src/scanner.c or src/scanner.cc
        -- optional entries:
        branch = "main",                              -- default branch in case of git repo if different from master
        generate_requires_npm = false,                -- if stand-alone parser without npm dependencies
        requires_generate_from_grammar = false,       -- if folder contains pre-generated src/parser.c
    },
    filetype = "d",                                   -- if filetype does not match the parser name
}
