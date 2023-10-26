local Hydra = require('hydra')
local colors = require('monolith.plugins.hydra.colors')
local cmd = require('hydra.keymap-util').cmd
local callback = require('monolith.plugins.hydra.callback');

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
  _p_: Telescope pickers     
  _f_: Fzf pickers           
  _u_: Url in current file   
  _l_: Licenses              
            Sudo           
  _w_: Write with sudo       
  _r_: Reopen with sudo      
            Misc           
  _s_: Special filenames     
                           
  _q_: Quit                  
└                         ┘
]]

function M.hydra() return Hydra({
        name = 'Help',
        hint = hintHelp,
        config = colors.passAllowMiddle(),
        mode = '',
        heads = {
            { 'c', cmd 'FzfLua commands' },
            { 'h', cmd 'FzfLua help_tags', { desc = 'vim help' } },
            { 'H', cmd 'Telescope howdoi' },
            { 'k', cmd 'FzfLua keymaps' },
            { 'o', cmd 'Telescope vim_options' },

            { ';', cmd 'FzfLua command_history' },
            { '?', cmd 'FzfLua search_history' },
            
            { 'p', cmd 'Telescope' },
            { 'f', cmd 'FzfLua' },
            { 'u', cmd 'UrlView' },
            
            { 'l', cmd 'Telescope software-licenses find' },
            
            { 'w', cmd 'SudaWrite' },
            { 'r', cmd 'SudaRead' },

            { 's', callback.hydraCallback('special-files') },
            
            { 'q', nil, { exit = true, nowait = true } },
            { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
        }
    })
end

return M;
