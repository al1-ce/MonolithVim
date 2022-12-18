local Hydra = require('hydra')
local colors = require('monolith.config.hydra.colors')
local cmd = require('hydra.keymap-util').cmd

local M = {}

local hintBuild = [[
┌──────── Build ────────┐
│ _b_: Default build task │
│ _B_: Select build task  │
│ _T_: All build tasks    │
├──────── Debug ────────┤
│ _d_: Open debugger      │
│ _t_: Toggle breakpoint  │
├───────────────────────┤
│ _q_: Quit               │
└───────────────────────┘
]]

function M.hydra() return Hydra({
        name = 'Build',
        hint = hintBuild,
        config = colors.passAllow(),
        mode = '',
        heads = {
            { 'b', cmd 'YabsDefaultTask' },
            { 'B', cmd 'Telescope yabs current_language_tasks' },
            { 'T', cmd 'Telescope yabs tasks' },

            { 'd', function() require("dapui").toggle() end },
            { 't', cmd 'DapToggleBreakpoint' },
            
            
            { 'q', nil, { exit = true, nowait = true } },
            { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
        }
    })
end

return M;
