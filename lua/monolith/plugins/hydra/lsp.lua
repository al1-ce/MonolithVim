local Hydra = require('hydra')
local colors = require('monolith.plugins.hydra.colors')
local cmd = require('hydra.keymap-util').cmd

local M = {}


local hintLsp = [[
┌         Lsp         ┐
  _a_: Code actions      
  _D_: Diagnostic        
  _f_: Finder            
  _h_: Hover doc         
        Symbols        
  _p_: Peek definition   
  _r_: Rename symbol     
  _s_: Symbol list       
  _S_: Symbol qflist     
         Go to         
  _d_: Definition        
  _R_: References        
  _I_: Implementations   
         Files         
  _F_: Format            
        Servers        
  _i_: Info              
  _T_: Stop in current   
                       
  _q_: Quit              
└                     ┘
]]

function stopLspInBuffer()
    local clients = vim.lsp.get_active_clients({bufnr = 0})
    for k, v in pairs(clients) do
        vim.lsp.buf_detach_client(0, v.id)
    end
end

function M.hydra() return Hydra({
        name = 'LSP',
        hint = hintLsp,
        config = colors.passAllow(),
        mode = '',
        heads = {
            { 'a', cmd 'Lspsaga code_action' },
            { 'D', cmd 'Lspsaga show_line_diagnostics' },
            { 'f', cmd 'FzfLua lsp_finder' },
            { 'h', cmd 'Lspsaga hover_doc' },

            { 'p', cmd 'Lspsaga peek_definition' },
            { 'r', cmd 'Lspsaga rename' },
            { 's', cmd 'FzfLua lsp_document_symbols' },
            { 'S', cmd 'lua vim.lsp.buf.document_symbol()' },

            { 'd', cmd 'FzfLua lsp_definitions' },
            { 'R', cmd 'FzfLua lsp_references' },
            { 'I', cmd 'FzfLua lsp_implementations' },

            { 'F', vim.lsp.buf.format },

            { 'i', cmd 'LspInfo'},
            { 'T', stopLspInBuffer },

            { 'q', nil, { exit = true, nowait = true } },
            { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
        }
    })
end

return M;
