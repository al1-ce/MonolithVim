local Hydra = require('hydra')
local colors = require('monolith.plugins.hydra.colors')
local cmd = require('hydra.keymap-util').cmd
local M = {}

local hintBuild = [[
┌         Debug         ┐
  _d_: Open debugger       
  _t_: Toggle breakpoint   
                         
  _q_: Quit                
└                       ┘
]]
--   _S_: Stop task process   

function M.hydra() return Hydra({
        name = 'Build',
        hint = hintBuild,
        config = colors.passAllow(),
        mode = '',
        heads = {
            ---@diagnostic disable-next-line: missing-parameter
            { 'd', function() require("dapui").toggle() end },
            { 't', cmd 'DapToggleBreakpoint' },

            { 'q', nil, { exit = true, nowait = true } },
            { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
        }
    })
end

return M;
