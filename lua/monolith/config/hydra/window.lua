local Hydra = require('hydra')
local colors = require('monolith.config.hydra.colors')
local cmd = require('hydra.keymap-util').cmd

local M = {}

local hintWindow = [[
┌── Move(S) ──┬── Size(C) ──┬───── Split ─────┐
│             │             │ _s_: Horizontally │
│      _↑_      │      _⇡_      │ _v_: Vertically   │
│   _←_  S  _→_   │   _⇠_  C  _⇢_   │ _=_: Equalize     │
│      _↓_      │      _⇣_      │ _o_: Only         │
│             │             │ _q_: Quit         │
└─────────────┴─────────────┴─────────────────┘
]] 

function M.hydra() return Hydra({
    name = 'Windows',
    hint = hintWindow,
    config = colors.persistQuit(),
    mode = '',
    heads = {
      { '<left>', '<C-w>h', { desc = false } },
      { '<down>', '<C-w>j', { desc = false } },
      { '<up>', '<C-w>k', { desc = false } },
      { '<right>', '<C-w>l', { desc = false } },
  
      { '<S-left>', cmd 'WinShift left', { desc = false } },
      { '<S-down>', cmd 'WinShift down', { desc = false } },
      { '<S-up>', cmd 'WinShift up', { desc = false } },
      { '<S-right>', cmd 'WinShift right', { desc = false } },
  
      { '<C-left>', function() require('smart-splits').resize_left(2) end, { desc = false } },
      { '<C-down>', function() require('smart-splits').resize_down(2) end, { desc = false } },
      { '<C-up>', function() require('smart-splits').resize_up(2) end, { desc = false } },
      { '<C-right>', function() require('smart-splits').resize_right(2) end, { desc = false } },
      { '=', '<C-w>=' },
      { 'o', cmd 'only' },
      -- { 'q', '<C-w>q', { exit = true, nowait = true } },
  
      { 's', cmd 'split' },
      { 'v', cmd 'vsplit' },
  
      { '←', nil },
      { '↑', nil },
      { '↓', nil },
      { '→', nil },
      { '⇠', nil },
      { '⇡', nil },
      { '⇣', nil },
      { '⇢', nil },
      { 'q', nil, { exit = true, nowait = true } },
      { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
    },
    })
end

return M;
