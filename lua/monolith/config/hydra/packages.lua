local Hydra = require('hydra')
local colors = require('monolith.config.hydra.colors')
local cmd = require('hydra.keymap-util').cmd

local M = {}

--[[
    https://vimawesome.com
    https://neovimcraft.com
    https://github.com/rockerBOO/awesome-neovim

    :Markify - mark lines
    :ToggleTerm?
    Yasb
    treesitter
    scrollbar toggle
    colorizer toggle
    vimspector
    nvim tree
    comment
    coc
    telescope
    tagbar
    c-w
    https://github.com/tpope/vim-surround
]]

local hintPackages = [[
┌──────── Packages ────────┐
│ _i_: Install               │
│ _c_: Clean                 │
│ _s_: Sync                  │
│ _u_: Update                │
│ _l_: List                  │
├──────── Language ────────┤
│ _m_: Mason lsp manager     │
├──────────────────────────┤
│ _q_: Quit                  │
└──────────────────────────┘
]]

function M.hydra() return Hydra({
    name = 'Packages',
    hint = hintPackages,
    config = colors.passAllow(),
    mode = '',
    heads = {
        { 'i', cmd 'PackerInstall' },
        { 'c', cmd 'PackerClean' },
        { 's', cmd 'PackerSync' },
        { 'u', cmd 'PackerUpdate' },
        { 'l', cmd 'Telescope packer' },

        { 'm', cmd 'Mason' },

        { 'q', nil, { exit = true, nowait = true } },
        { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
    }
    })
end
----------------------------------------------------------------------
--                             comment                              --
----------------------------------------------------------------------

return M;
