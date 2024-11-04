return {
    {
        'numToStr/Comment.nvim',
        lazy = false,
        config = function()
            local cm = require("Comment")

            ---@diagnostic disable-next-line: missing-fields
            cm.setup {
                ignore = "^$",
                mappings = {
                    ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                    basic = true,
                    ---Extra mapping; `gco`, `gcO`, `gcA`
                    extra = true,
                }
            }

            local ft = require("Comment.ft")
            -- FIXME: should be a commentstring in ftplugin
            ft({ 'd' }, ft.get('c'))
            ft({ 'sdl' }, ft.get('c'))
            ft({ 'sdlang' }, ft.get('c'))
            ft({ 'kdl' }, ft.get('c'))
            ft({ 'vox' }, ft.get('c'))
            ft({ 'zscript' }, ft.get('c'))
            ft({ 'zdoomlump' }, ft.get('c'))
        end,
    },
}

