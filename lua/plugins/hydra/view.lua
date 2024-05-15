local Hydra = require('hydra')
local colors = require('plugins.hydra.colors')
local cmd = require('hydra.keymap-util').cmd

local M = {}

local hintPackages = [[
┌           View           ┐
  _m_: Preview markdown glow
  _t_: View todo
            Link
  _V_: VimAwesome
  _N_: Neocraft
  _A_: Awesome Vim
  _L_: Vim plugin list

  _q_: Quit
└                          ┘
]]

function M.hydra()
    return Hydra({
        name = 'Packages',
        hint = hintPackages,
        config = colors.passAllow(),
        mode = '',
        heads = {
            { 'm',     cmd 'Glow' },
            -- { 'M',     cmd 'MarkdownPreview' },
            -- { 't',     cmd 'TODOTelescope' },
            { 't',     cmd 'TodoLocList' },

            { 'V',     cmd 'silent! !xdg-open https://vimawesome.com' },
            { 'N',     cmd 'silent! !xdg-open https://neovimcraft.com' },
            { 'A',     cmd 'silent! !xdg-open https://github.com/rockerBOO/awesome-neovim' },
            { 'L',     cmd 'silent! !xdg-open https://github.com/altermo/vim-plugin-list' },
            { 'q',     nil, { exit = true, nowait = true } },
            { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
        }
    })
end

return M;
