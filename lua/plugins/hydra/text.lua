local Hydra = require('hydra')
local colors = require('plugins.hydra.colors')
local cmd = require('hydra.keymap-util').cmd

local M = {}

local hintText = [[
┌            Text           ┐
  _b_: Toggle bool
           Surround
  _r_: Replace surround
  _R_: Remove surround
           Comments
  _/_: Toggle comment lines
  _?_: Toggle comment block
  _a_: Make ascii art
           Terminal
  _t_: Float terminal
             Tabs
  _n_: New tab
  _w_: Close tab
  _o_: Close other tabs
            Plugin
  _m_: Marks
  _p_: Pick color

  _q_: Quit
└                           ┘
]]

local callback = require('plugins.hydra.callback');

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
        { 'b', require('nvim-toggler').toggle },

        { 'r', '<Plug>Csurround' },
        { 'R', '<Plug>Dsurround' },

        { '/', commentLines },
        { '?', commentBlocks },
        -- { 'l', require('nvim-comment-frame').add_comment },
        -- { 'B', require('nvim-comment-frame').add_multiline_comment },
        { 'a', cmd 'Commentalist' },

        { 't', cmd 'Lspsaga term_toggle' },

        { 'n', cmd '$tabnew' },
        { 'w', cmd 'tabclose' },
        { 'o', cmd 'tabonly' },

        { 'm', cmd 'FzfLua marks' },
        -- { 'd', callback.hydraCallback('draw'); },
        { 'p', cmd 'CccPick' },

        { 'q', nil, { exit = true, nowait = true } },
        { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
    }
}) end

return M;
