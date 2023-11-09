local Hydra = require('hydra')
local colors = require('monolith.plugins.hydra.colors')
local cmd = require('hydra.keymap-util').cmd

local M = {}

local fUpdateConf = function()
    vim.cmd([[
    update $MYVIMRC
    source $MYVIMRC
    ]])
    vim.notify("Nvim config successfully reloaded!", vim.log.levels.INFO, { title = "nvim-config" })
end

local hintConfig = [[
┌        Config        ┐
  _e_: Edit               
  _r_: Reload             
         Session        
  _s_: Save session       
  _l_: Load session       
           Dir          
  _d_: Change directory   
                        
  _q_: Quit               
└                      ┘
]]

function M.hydra() return Hydra({
        name = 'Config',
        hint = hintConfig,
        config = colors.passAllow(),
        mode = '',
        heads = {
            { 'e', cmd 'edit $MYVIMRC <bar> tcd %:h' },
            { 'r', fUpdateConf },

            { 's', cmd 'SessionsSave' },
            { 'l', cmd 'SessionsLoad' },

            { 'd', '<cmd>cd %:p:h<cr><cmd>pwd<cr>' },

            { 'q', nil, { exit = true, nowait = true } },
            { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
        }
    })
end

return M;
