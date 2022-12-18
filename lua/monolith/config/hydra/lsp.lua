local Hydra = require('hydra')
local colors = require('monolith.config.hydra.colors')
local cmd = require('hydra.keymap-util').cmd

local M = {}

local hintLsp = [[
┌──────── Lsp ────────┐
│ _d_: Definition       │
│ _i_: Implementations  │
│ _r_: References       │
│ _s_: Symbols          │
│ _f_: Format           │
│ _a_: Code actions     │
| _x_: Scratchpad       |
├─────────────────────┤
│ _q_: Quit             │
└─────────────────────┘
]] -- TODO: formatting

function M.hydra() return Hydra({
        name = 'LSP',
        hint = hintLsp,
        config = colors.passAllow(),
        mode = '',
        heads = {
            { 'd', cmd 'Telescope lsp_definitions' },
            { 'i', cmd 'Telescope lsp_implementations' },
            { 'r', cmd 'Telescope lsp_references' },
            { 's', cmd 'Telescope lsp_document_symbols' },
            { 'f', vim.lsp.buf.format },
            { 'a', cmd 'Lspsaga code_action' },
            { 'x', cmd 'Codi javascript' },
            
            { 'q', nil, { exit = true, nowait = true } },
            { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
        }
    })
end

return M;
