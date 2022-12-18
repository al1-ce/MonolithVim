local Hydra = require('hydra')
local colors = require('monolith.config.hydra.colors')
local cmd = require('hydra.keymap-util').cmd

local M = {}

local hintBuild = [[
┌──────── Build ────────┐
│ _b_: Default build task │
│ _s_: Select build task  │
│ _a_: All build tasks    │
├──────── Debug ────────┤
│ _d_: Open debugger      │
│ _p_: Toggle breakpoint  │
├──────── Other ────────┤
│ _T_: Todo               │
│ _t_: Toggle terminal    │
│ _f_: Float terminal     │
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
            { 's', cmd 'Telescope yabs current_language_tasks' },
            { 'a', cmd 'Telescope yabs tasks' },

            { 'd', function() require("dapui").toggle() end },
            { 'p', cmd 'DapToggleBreakpoint' },
            
            { 'T', cmd 'TODOTelescope' },
            { 't', cmd 'ToggleTerm direction="horizontal"' },
            { 'f', cmd 'ToggleTerm direction="float"' },
            
            { 'q', nil, { exit = true, nowait = true } },
            { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
        }
    })
end

return M;
