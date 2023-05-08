local Hydra = require('hydra')
local colors = require('monolith.config.hydra.colors')
local cmd = require('hydra.keymap-util').cmd

local M = {}

local hintWindow = [[
┌        Window        ┐
  _s_: Horizontal split   
  _v_: Vertical split     
  _=_: Equalize           
  _o_: Close others       
                        
  _q_: Quit               
└                      ┘
]]

function M.hydra() return Hydra({
    name = 'Windows',
    hint = hintWindow,
    config = colors.passAllow(),
    mode = '',
    heads = {
      { '=', '<C-w>=' },
      { 'o', cmd 'only' },
      -- { 'q', '<C-w>q', { exit = true, nowait = true } },

      { 's', cmd 'split' },
      { 'v', cmd 'vsplit' },

      { 'q', nil, { exit = true, nowait = true } },
      { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
    },
    })
end

return M;
