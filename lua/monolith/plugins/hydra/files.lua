local Hydra = require('hydra')
local colors = require('monolith.plugins.hydra.colors')
local cmd = require('hydra.keymap-util').cmd

local M = {}

local hintFiles = [[
┌      Files      ┐
  _f_: Find file     
  _r_: Recent files  
  _p_: Projects      
  _s_: Swap alt      
  _e_: Edit new      
       Regex       
  _F_: Find in file  
  _R_: Replace file  
  _g_: Live grep     
       Trees       
  _T_: Tagbar        
  _u_: Undo tree     
  _S_: Sidebar       
  _m_: Minimap       
                   
  _q_: Quit          
└                 ┘
]]

--  _t_: File tree     

local fzf = require("fzf-lua")

local function mediaCall()
    require("telescope").extensions.media.media({cwd=vim.fn.getcwd()})
end

local function reverse(tab)
    for i = 1, #tab/2, 1 do
        tab[i], tab[#tab-i+1] = tab[#tab-i+1], tab[i]
    end
    return tab
end

local function deleteProject(paths)
    for _,fpath in ipairs(paths) do
        local choice = vim.fn.confirm("Delete '" .. fpath .. "' from project list?", "&Yes\n&No", 2)

        if choice == 1 then
            require("project_nvim.utils.history").delete_project({value = fpath})
        end
    end
end

local function fzfProjects()
    require("fzf-lua").fzf_exec(
        reverse(require("project_nvim").get_recent_projects()),
        {
            prompt = " ",
            -- fzf_opts = {['--layout'] = 'reverse'},
            actions = {
                ['default'] = function(selected, opts) fzf.files({cwd = selected[1]}) end,
                ["ctrl-d"] = deleteProject,
                ["ctrl-w"] = function(selected, opts) vim.api.nvim_set_current_dir(selected[1]) end,
            }
        }
    )
end

function M.hydra() return Hydra({
        name = 'Files',
        hint = hintFiles,
        config = colors.passAllow(),
        mode = '',
        heads = {
            { 'f', cmd 'FzfLua files' },
            -- { 'f', mediaCall },
            { 'r', cmd 'FzfLua oldfiles' },
            -- { 'p', cmd 'Telescope projects' },
            { 'p', fzfProjects },
            { 's', '<C-^>' },
            { 'e', cmd 'enew' },

            { 'F', cmd 'FzfLua blines' },
            { 'R', require('spectre').open },
            { 'g', cmd 'FzfLua grep_project' },

            -- { 't', ':NvimTreeToggle<cr><C-w>l' },
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
