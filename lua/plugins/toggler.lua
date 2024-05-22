local sysdep = require("utils.sysdep")
local noremap = require("utils.noremap")

return {
    -- Toggle tags [ \tp ]
    {
        'nguyenvukhang/nvim-toggler',
        config = function()
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
                    ['above'] = 'below',
                },
                remove_default_keybinds = true,
            })

            noremap("n", "<C-`>", require('nvim-toggler').toggle, {desc = "Toggles value under cursor"})
            noremap("v", "<C-`>", require('nvim-toggler').toggle, {desc = "Toggles value under cursor"})
            noremap("n", "<leader>ct", require('nvim-toggler').toggle, {desc = "Toggles value under cursor"})
            noremap("v", "<leader>ct", require('nvim-toggler').toggle, {desc = "Toggles value under cursor"})
        end
    }
}
