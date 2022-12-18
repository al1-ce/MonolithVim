local Hydra = require('hydra')
local colors = require('monolith.config.hydra.colors')
local cmd = require('hydra.keymap-util').cmd

local M = {}

local hintFiles = [[
┌───── Files ─────┐
│ _f_: Files        │
│ _r_: Recent files │
│ _p_: Projects     │
│ _b_: Browser      │
│ _s_: Swap alt     │
│ _e_: New file     │
├───── Regex ─────┤
│ _F_: Search       │
│ _R_: Replace file │
│ _g_: Live grep    │
├───── Trees ─────┤
│ _t_: File tree    │
│ _T_: Tagbar       │
│ _u_: Undo tree    │
│ _S_: Sidebar      │
│ _m_: Minimap      │
├─────────────────┤
│ _q_: Quit         │
└─────────────────┘
]]

function M.hydra() return Hydra({
        name = 'Files',
        hint = hintFiles,
        config = colors.passAllow(),
        mode = '',
        heads = {
            { 'f', cmd 'Telescope find_files' },
            { 'r', cmd 'Telescope oldfiles' },
            { 'p', cmd 'Telescope projects' },
            { 'b', cmd 'Telescope file_browser' },
            { 's', '<C-^>' },
            { 'e', cmd 'enew' },
            
            { 'F', cmd 'Telescope current_buffer_fuzzy_find' },
            { 'R', require('spectre').open },
            { 'g', cmd 'Telescope live_grep' },

            { 't', ':NvimTreeToggle<cr><C-w>l' },
            { 'T', cmd 'Lspsaga outline' },
            { 'u', cmd 'UndotreeToggle' },
            { 'S', cmd 'SidebarNvimToggle' },
            { 'm', require('mini.map').toggle },
            
            { 'q', nil, { exit = true, nowait = true } },
            { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
        }
    })
end

return M;
