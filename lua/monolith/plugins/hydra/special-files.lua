local Hydra = require('hydra')
local colors = require('monolith.plugins.hydra.colors')
local cmd = require('hydra.keymap-util').cmd

local M = {}

local hintHelp = [[
┌       Special files       ┐
                             
  justfile - Build makefile  
  .todo.md - Todolist        
                             
  _q_: Quit                
└                           ┘
]]

function M.hydra() return Hydra({
        name = 'SpecialFiles',
        hint = hintHelp,
        config = colors.persistBlock(),
        mode = '',
        heads = {
            { 'q', nil, { exit = true, nowait = true } },
            { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
        }
    })
end

return M;
