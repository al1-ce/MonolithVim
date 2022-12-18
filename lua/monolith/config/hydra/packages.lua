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
├────────── View ──────────┤
│ _g_: Preview markdown glow │
│ _M_: Preview markdown web  │
├────────── Link ──────────┤
│ _V_: VimAwesome            │
│ _N_: Neocraft              │
│ _A_: Awesome Vim           │
│ _L_: Vim plugin list       │
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

        { 'g', cmd 'Glow' },
        { 'M', cmd 'MarkdownPreview', {exit = true, nowait = true} },
        
        { 'V', cmd 'silent! !xdg-open https://vimawesome.com' },
        { 'N', cmd 'silent! !xdg-open https://neovimcraft.com' },
        { 'A', cmd 'silent! !xdg-open https://github.com/rockerBOO/awesome-neovim' },
        { 'L', cmd 'silent! !xdg-open https://github.com/altermo/vim-plugin-list' },
        
        { 'q', nil, { exit = true, nowait = true } },
        { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
    }
    })
end

return M;
