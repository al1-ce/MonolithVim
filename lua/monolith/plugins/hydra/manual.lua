local Hydra = require('hydra')
local colors = require('monolith.plugins.hydra.colors')
local cmd = require('hydra.keymap-util').cmd

local M = {}

local hintHelp = [[
┌           Help          ┐
  _c_: Execute command       
  _h_: Vim help              
  _H_: Howdoi                
  _k_: Keymaps               
  _o_: Vim options           
          History          
  _;_: Commands history      
  _?_: Search history        
          Pickers          
  _p_: All pickers           
  _u_: Url in current file   
  _l_: Licenses              
            Sudo           
  _w_: Write with sudo       
  _r_: Reopen with sudo      
                           
  _q_: Quit                  
└                         ┘
]]

function M.hydra() return Hydra({
        name = 'Help',
        hint = hintHelp,
        config = colors.passAllowMiddle(),
        mode = '',
        heads = {
            { 'c', cmd 'Telescope commands' },
            { 'h', cmd 'Telescope help_tags', { desc = 'vim help' } },
            { 'H', cmd 'Telescope howdoi' },
            { 'k', cmd 'Telescope keymaps' },
            { 'o', cmd 'Telescope vim_options' },

            { ';', cmd 'Telescope command_history' },
            { '?', cmd 'Telescope search_history' },
            
            { 'p', cmd 'Telescope' },
            { 'u', cmd 'UrlView' },
            
            { 'l', cmd 'Telescope software-licenses find' },
            
            { 'w', cmd 'SudaWrite' },
            { 'r', cmd 'SudaRead' },
            
            { 'q', nil, { exit = true, nowait = true } },
            { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
        }
    })
end

return M;
