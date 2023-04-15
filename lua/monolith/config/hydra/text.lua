local Hydra = require('hydra')
local colors = require('monolith.config.hydra.colors')
local cmd = require('hydra.keymap-util').cmd

local M = {}

local hintText = [[
┌─────────── Text ──────────┐
│ _b_: Toggle bool            │
├───────── Surround ────────┤
│ _s_: Surround word          │
│ _S_: Surround line          │
│ _r_: Replace surround       │
│ _R_: Remove surround        │
│ _'_: Surround around        │
│ _"_: Surround in            │
├────────── Aligns ─────────┤
│ _a_: Align around first     │
│ _A_: Align around all       │
├───────── Comments ────────┤
│ _/_: Toggle comment lines   │
│ _?_: Toggle comment block   │
│ _l_: Add comment line       │
│ _B_: Add comment box        │
├───────── Terminal ────────┤
│ _t_: Toggle terminal        │
│ _f_: Float terminal (saga)  │
│ _F_: Float terminal (tgtm)  │
├─────────── Tabs ──────────┤
│ _n_: New tab                │
│ _w_: Close tab              │
│ _o_: Close other tabs       │
├───────── Telescope ───────┤
│ _m_: Marks                  │
├────────── Plugin ─────────┤
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
        { 'b', require('nvim-toggler').toggle },

        { 'a', '<Plug>(EasyAlign)ip=' },
        { 'A', '<Plug>(EasyAlign)ip*=' },

        { 's', '<Plug>Ysurroundiw' },
        { 'S', '<Plug>Yssurround' },
        { 'r', '<Plug>Csurround' },
        { 'R', '<Plug>Dsurround' },
        { "'", '<Plug>Ysurround2i' },
        { '"', '<Plug>Ysurroundi' },

        { '/', commentLines },
        { '?', commentBlocks },
        { 'l', require('nvim-comment-frame').add_comment },
        { 'B', require('nvim-comment-frame').add_multiline_comment },

        { 't', cmd 'ToggleTerm direction="horizontal"' },
        { 'f', cmd 'Lspsaga term_toggle' },
        { 'F', cmd 'ToggleTerm direction="float"' },

        { 'n', cmd '$tabnew' },
        { 'w', cmd 'tabclose' },
        { 'o', cmd 'tabonly' },

        { 'm', cmd 'Telescope marks' },

        { 'd', callback.hydraCallback('draw'); },
        { 'p', cmd 'PickColor' },
        { 'u', cmd 'Telescope symbols' }, -- emoji

        { 'q', nil, { exit = true, nowait = true } },
        { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
    }
}) end

return M;
