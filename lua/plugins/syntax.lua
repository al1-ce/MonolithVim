local sysdep = require("utils.sysdep")

return {
    'fladson/vim-kitty', -- just a syntax file
    'tikhomirov/vim-glsl',
    -- Dart
    'dart-lang/dart-vim-plugin',
    -- 'natebosch/vim-lsc'
    -- 'natebosch/vim-lsc-dart'
    {
        "NoahTheDuke/vim-just",
        event = { "BufReadPre", "BufNewFile" },
        ft = { "\\cjustfile", "*.just", ".justfile", "justfile" },
    },
    {
        "IndianBoy42/tree-sitter-just",
        dependencies = { "nvim-treesitter/nvim-treesitter" }
    },
    {
        'Fymyte/rasi.vim',
        ft = 'rasi',
    }
}
