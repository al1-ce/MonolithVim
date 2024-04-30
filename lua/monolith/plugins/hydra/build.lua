local Hydra = require('hydra')
local colors = require('monolith.plugins.hydra.colors')
local cmd = require('hydra.keymap-util').cmd
local builder = require('monolith.plugins.utils.justbuild')
local M = {}

local hintBuild = [[
┌         Build         ┐
  _d_: Default task        
  _b_: Build task          
  _r_: Run task            
  _t_: Test task           
  _a_: All tasks           
  _c_: Create build file   
  _s_: Stop current job    
                         
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
            { 'd', builder.run_task_default },
            { 'b', builder.run_task_build },
            { 'r', builder.run_task_run },
            { 't', builder.run_task_test },
            { 'a', builder.run_task_select },
            { 'c', builder.add_build_template }, -- HAS CONFIRM FUNC
            { 's', builder.stop_current_task },

            { 'q', nil, { exit = true, nowait = true } },
            { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
        }
    })
end

return M;
