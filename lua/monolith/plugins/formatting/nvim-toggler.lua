require('nvim-toggler').setup({
    inverses = {
        -- BOOLEANS
        ['TRUE'] = 'FALSE',
        ['True'] = 'False',
        ['1'] = '0',
        -- VISIBILITY
        ['public'] = 'private',
        -- OPERATIONS
        ['++'] = '--',
        ['+'] = '-',
        ['<'] = '>',
        ['<='] = '>=',
        ['&&'] = '||',
        -- MISC
        ['[ ]'] = '[x]',
        ['""'] = "''",
        -- TYPES
        ['struct'] = 'class',
        ['float'] = 'double',
        -- COLORS
        ['white'] = 'black',
        -- CSS
        ['always'] = 'never',
        ['top'] = 'bottom',
        ['left'] = 'right',
        ['relative'] = 'absolute',
        ['width'] = 'height',
        ['vertical'] = 'horizontal',
        ['show'] = 'hide',
        ['outset'] = 'inset',
        ['row'] = 'column',
        ['start'] = 'end',
        ['after'] = 'before',
    },
    remove_default_keybinds = true,
})

local opts = { noremap = true, silent = true }

local keymap = vim.keymap

keymap.set("n", "<C-`>", require('nvim-toggler').toggle, opts)

