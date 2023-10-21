local Hydra = require('hydra')
local colors = require('monolith.plugins.hydra.colors')
local cmd = require('hydra.keymap-util').cmd
local builder = require('monolith.plugins.utils.justbuild')
local M = {}

local hintBuild = [[
┌         Build         ┐
  _b_: Default build task  
  _r_: Default run task    
  _B_: File build tasks    
  _T_: All tasks           
          Debug          
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
            { 'b', builder.run_default_task },
            { 'r', builder.run_default_run_task },
            { 'B', builder.run_build_select_lang },
            { 'T', builder.run_build_select },
            -- { 'S', cmd 'AsyncStop!' },

            ---@diagnostic disable-next-line: missing-parameter
            { 'd', function() require("dapui").toggle() end },
            { 't', cmd 'DapToggleBreakpoint' },

            { 'q', nil, { exit = true, nowait = true } },
            { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
        }
    })
end

return M;
