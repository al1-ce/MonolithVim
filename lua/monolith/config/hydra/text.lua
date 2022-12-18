local Hydra = require('hydra')
local colors = require('monolith.config.hydra.colors')
local cmd = require('hydra.keymap-util').cmd

local M = {}

local hintText = [[
┌─────────── Text ──────────┐
│ _t_: Toggle bool            │
├───────── Comments ────────┤
│ _/_: Toggle comment lines   │
│ _?_: Toggle comment block   │
│ _s_: Add comment separator  │
│ _b_: Add comment box        │
├──────── Navigation ───────┤
│ _h_: Headers                │
│ _c_: Clipboard              │
├─────────── Plugin ────────┤
│ _d_: Draw                   │
│ _p_: Pick color             │
│ _u_: Symbols                │
├───────────────────────────┤
│ _q_: Quit                   │
└───────────────────────────┘
]]

local callback = require('monolith.config.hydra.callback');

local commentApi = require("Comment.api")
local commentEsc = vim.api.nvim_replace_termcodes(
    '<ESC>', true, false, true
)
local commentLines = function() 
    local mode = vim.api.nvim_get_mode().mode
    if mode == 'v' or mode == 'V' or mode == '^V' then
        vim.api.nvim_feedkeys(commentEsc, 'nx', false)
        commentApi.toggle.linewise(vim.fn.visualmode()) 
    else
        commentApi.toggle.linewise.current()
    end
end
local commentBlocks = function() 
    local mode = vim.api.nvim_get_mode().mode
    if mode == 'v' or mode == 'V' or mode == '^V' then
        vim.api.nvim_feedkeys(commentEsc, 'nx', false)
        commentApi.toggle.blockwise(vim.fn.visualmode()) 
    else
        commentApi.toggle.blockwise.current()
    end
end

function M.hydra() return Hydra({
    name = 'Text',
    hint = hintText,
    config = colors.passAllow(),
    mode = '',
    heads = {
        -- { '=', '<C-w>=' },
        -- { 's', cmd 'split' },
        -- { '/', commentApi.toggle.linewise.current },
        { 't', require('nvim-toggler').toggle },

        { '/', commentLines },
        { '?', commentBlocks },
        { 's', require('nvim-comment-frame').add_comment },
        { 'b', require('nvim-comment-frame').add_multiline_comment },

        { 'h', cmd 'Telescope heading' },
        { 'c', cmd 'Telescope neoclip' },

        { 'd', callback.hydraCallback('draw'); },
        { 'p', cmd 'PickColor' },
        { 'u', cmd 'Telescope symbols' }, -- emoji

        { 'q', nil, { exit = true, nowait = true } },
        { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
    }
}) end

return M;