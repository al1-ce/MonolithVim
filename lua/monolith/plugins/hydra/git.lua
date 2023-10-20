local Hydra = require('hydra')
local colors = require('monolith.plugins.hydra.colors')
local cmd = require('hydra.keymap-util').cmd

local M = {}

local hintGit = [[
┌     git     ┐
  _s_: Status    
  _b_: Branches  
  _c_: Commits   
  _S_: Stash     
  _d_: Diff      
               
  _q_: Quit      
└             ┘
]]

function M.hydra() return Hydra({
        name = 'Git',
        hint = hintGit,
        config = colors.passAllow(),
        mode = '',
        heads = {
            { 's', cmd 'Telescope git_status' },
            { 'b', cmd 'Telescope git_branches' },
            { 'c', cmd 'Telescope git_commits' },
            { 'S', cmd 'Telescope git_stash' },
            { 'd', cmd 'DiffviewOpen' },
            { 'q', nil, { exit = true, nowait = true } },
            { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
        }
    })
end

return M;
