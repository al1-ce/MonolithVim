local Hydra = require('hydra')
local colors = require('monolith.config.hydra.colors')
local cmd = require('hydra.keymap-util').cmd

local M = {}

local hintOptions = [[
┌          Options           ┐
  _v_ %{ve} Virtual edit          
  _i_ %{list} Invisible characters  
  _s_ %{spell} Spell                 
  _w_ %{wrap} Wrap                  
  _c_ %{cul} Cursor line           
  _n_ %{nu} Line numbers          
  _r_ %{rnu} Relative number       
                              
  _q_: Quit                     
└                            ┘
]]

function M.hydra() return Hydra({
        name = 'Options',
        hint = hintOptions,
        config = colors.persistBlock(),
        mode = 'n',
        heads = {
            { 'n', function() vim.o.number = not vim.o.number end },
            { 'r', function()
                vim.o.relativenumber = not vim.o.relativenumber
                if vim.o.relativenumber == true then
                    vim.o.number = true
                end
            end },
            { 'v', function()
                if vim.o.virtualedit == 'all' then
                    vim.o.virtualedit = 'onemore'
                else
                    vim.o.virtualedit = 'all'
                end
            end  },
            { 'i', function() vim.o.list = not vim.o.list end  },
            { 's', function() vim.o.spell = not vim.o.spell end },
            { 'w', function() vim.o.wrap = not vim.o.wrap end },
            { 'c', function() vim.o.cursorline = not vim.o.cursorline end  },
            { 'q', nil, { exit = true, nowait = true } },
            { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
            { '\\', nil, { exit = true, nowait = true, desc = false } },
        }
    })
end

return M;
