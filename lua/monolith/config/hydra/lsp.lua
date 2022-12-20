local Hydra = require('hydra')
local colors = require('monolith.config.hydra.colors')
local cmd = require('hydra.keymap-util').cmd

local M = {}

local hintLsp = [[
┌──────── Lsp ────────┐
│ _D_: Definition       │
│ _i_: Implementations  │
│ _r_: References       │
│ _s_: Symbols          │
│ _d_: Diagnostic       │
│ _R_: Rename symbol    │
│ _f_: Format           │
│ _a_: Code actions     │
│ _x_: Scratchpad       │
│ _T_: Stop in current  │
├─────────────────────┤
│ _q_: Quit             │
└─────────────────────┘
]] -- TODO: formatting

function stopLspInBuffer()
    local clients = vim.lsp.get_active_clients({bufnr = 0})
    for k, v in pairs(clients) do
        vim.lsp.buf_detach_client(0, v.id)
    end
end

function M.hydra() return Hydra({
        name = 'LSP',
        hint = hintLsp,
        config = colors.passAllow(),
        mode = '',
        heads = {
            { 'D', cmd 'Telescope lsp_definitions' },
            { 'i', cmd 'Telescope lsp_implementations' },
            { 'r', cmd 'Telescope lsp_references' },
            { 's', cmd 'Telescope lsp_document_symbols' },
            { 'd', cmd 'Lspsaga show_line_diagnostics' },
            { 'R', cmd 'Lspsaga rename' },
            { 'f', vim.lsp.buf.format },
            { 'a', cmd 'Lspsaga code_action' },
            { 'x', cmd 'Codi javascript' },
            { 'T', stopLspInBuffer },
            
            { 'q', nil, { exit = true, nowait = true } },
            { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
        }
    })
end

return M;
