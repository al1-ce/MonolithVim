
local ft = require('Comment.ft')
local cm = require('Comment')

cm.setup {
    mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = false,
    }
}

ft({ 'd' }, ft.get('c'))
ft({ 'sdl' }, ft.get('c'))
ft({ 'sdlang' }, ft.get('c'))

require('nvim-comment-frame').setup({

    -- if true, <leader>cf keymap will be disabled
    disable_default_keymap = true,

    -- configurations for individual language goes here
    languages = {
        d = {
            -- start the comment with this string
            start_str = '/* ',
            -- end the comment line with this string
            end_str = ' */',
            -- fill the comment frame border with this character
            fill_char = '-',
            -- width of the comment frame
            frame_width = 80,
            -- wrap the line after 'n' characters
            line_wrap_len = 70,
            -- automatically indent the comment frame based on the line
            auto_indent = true,
        },
    }
})

local opts = { noremap = true, silent = true }

local keymap = vim.keymap

local commentApi = require("Comment.api")
local commentEsc = vim.api.nvim_replace_termcodes(
    '<ESC>', true, false, true
)
keymap.set("v", "<C-/>", function()
    vim.api.nvim_feedkeys(commentEsc, 'nx', false)
    commentApi.toggle.linewise(vim.fn.visualmode())
end);
keymap.set("v", "<C-S-/>", function()
    vim.api.nvim_feedkeys(commentEsc, 'nx', false)
    commentApi.toggle.blockwise(vim.fn.visualmode())
end);
keymap.set("n", "<C-/>", commentApi.toggle.linewise.current, opts);
keymap.set("i", "<C-/>", commentApi.toggle.linewise.current, opts);

