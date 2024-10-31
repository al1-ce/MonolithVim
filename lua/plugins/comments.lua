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
            ft({ 'd' }, ft.get('c'))
            ft({ 'sdl' }, ft.get('c'))
            ft({ 'sdlang' }, ft.get('c'))
            ft({ 'kdl' }, ft.get('c'))
            ft({ 'vox' }, ft.get('c'))
            ft({ 'zscript' }, ft.get('c'))
            ft({ 'zdoomlump' }, ft.get('c'))
        end,
    },
    {
        "LudoPinelli/comment-box.nvim",
        opts = {
            comment_style = "line", -- line
            doc_width = 80, -- width of the document
            box_width = 80, -- width of the boxes
            borders = { -- symbols used to draw a box
                top          = "-",
                bottom       = "-",
                left         = " - ",
                right        = " -",
                top_left     = " - ",
                top_right    = " -",
                bottom_left  = " - ",
                bottom_right = " -",
            },
            line_width = 80, -- width of the lines
            lines = { -- symbols used to draw a line
                line        = "-",
                line_start  = "- ",
                line_end    = " -",
                title_left  = "---",
                title_right = "---",
            },
            outer_blank_lines_above = false, -- insert a blank line above the box
            outer_blank_lines_below = false, -- insert a blank line below the box
            inner_blank_lines = false, -- insert a blank line above and below the text
            line_blank_line_above = false, -- insert a blank line above the line
            line_blank_line_below = false, -- insert a blank line below the line
        },
        keys = {
            -- { "<leader>cb", "<cmd>CBclbox<cr>",  mode = "v", noremap = true, silent = true, desc = "[C]omment [B]ox" },
            { "<leader>cb", "<cmd>CBccbox<cr>",  mode = "v", noremap = true, silent = true, desc = "[C]omment [B]ox" },
            { "<leader>cb", "<cmd>CBclline<cr>", mode = "n", noremap = true, silent = true, desc = "[C]omment [B]ox line" },
            { "<leader>cl", "<cmd>CBline<cr>",   mode = "n", noremap = true, silent = true, desc = "[C]omment solid [L]ine" },
            { "<leader>cr", "<cmd>CBd<cr>",      mode = "n", noremap = true, silent = true, desc = "[C]omment box [R]emove" },
        },
        event = "VimEnter"
    }
}

