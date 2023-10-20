local null_ls = require("null-ls")

null_ls.setup({
    -- debug = true,
    sources = {
        null_ls.builtins.formatting.dfmt.with({
            -- cmd = "dfmt",
            extra_args = {
                '--brace_style', 'otbs',
                '--align_switch_statements', 'true',
                '--compact_labeled_statements', 'true',
                '--keep_line_breaks', 'true',
                '--indent_style', 'space',
                '--indent_size', '4',
                '--soft_max_line_length', '80',
                '$FILENAME'
            },
            filetypes = { "d", 'dub', 'rdmd' },
        }),
        null_ls.builtins.formatting.stylelint
    },
    -- on_attach = on_attach_null_ls
})

