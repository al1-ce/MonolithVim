require('nvim-toggler').setup({
    inverses = {
        ['TRUE'] = 'FALSE',
        ['True'] = 'False',
        ['1'] = '0',
        ['public'] = 'private',
        ['[ ]'] = '[x]',
        ['++'] = '--',
        ['+'] = '-',
        ['""'] = "''",
        ['struct'] = 'class',
        ['always'] = 'never',
        ['float'] = 'double',
        ['top'] = 'bottom',
        ['left'] = 'right',
        ['relative'] = 'absolute',
        ['white'] = 'black',
        ['width'] = 'height',
        ['vertical'] = 'horizontal',
        ['show'] = 'hide',
        ['outset'] = 'inset',
        ['<'] = '>',
        ['<='] = '>=',
        ['&&'] = '||',
    },
    remove_default_keybinds = true,
})

local opts = { noremap = true, silent = true }

local keymap = vim.keymap

keymap.set("n", "<C-`>", require('nvim-toggler').toggle, opts)

