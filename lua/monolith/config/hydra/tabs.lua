local Hydra = require('hydra')
local colors = require('monolith.config.hydra.colors')
local cmd = require('hydra.keymap-util').cmd

local M = {}

local hintTabs = [[
    ┌── Move(S) ──┬── Tabs ──┐
    │             │ _t_: New   │
    │             │ _w_: Close │
    │   _←_  S  _→_   │ _o_: Only  │
    │             │          │
    │             │ _q_: Quit  │
    └─────────────┴──────────┘
    ]]
-- TODO: tabs
function M.hydra() return Hydra({
        name = 'Windows',
        hint = hintTabs,
        config = colors.persistQuit(),
        mode = '',
        heads = {
            { '<left>', cmd 'tabprevious', { desc = false } },
            { '<right>', cmd 'tabnext', { desc = false } },
            { '<S-left>', cmd 'tabmove -1', { desc = false } },
            { '<S-right>', cmd 'tabmove +1', { desc = false } },
            { 't', cmd '$tabnew' },
            { 'w', cmd 'tabclose' },
            { 'o', cmd 'tabonly' },

            { '←', nil },
            { '→', nil },
            { 'q', nil, { exit = true, nowait = true } },
            { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
        },
    })
end

return M;
