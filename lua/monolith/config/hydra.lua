local Hydra = require('hydra')

-- https://github.com/anuvyklack/hydra.nvim

local cmd = require('hydra.keymap-util').cmd

local callback = require('monolith.config.hydra.callback');
local colors = require('monolith.config.hydra.colors');

local hintLeader = [[
┌────── Menu ──────┐
│ _f_: Files         │
│ _t_: Text          │
├───── Devenv ─────┤
│ _l_: Lsp           │
│ _g_: Git           │
│ _b_: Build         │
├────── Misc ──────┤
│ _d_: Dashboard     │
│ _p_: Preview/Pkg   │
├──── Settings ────┤
│ _c_: Config/Dir    │
│ _o_: Options       │
│ _h_: Help          │
├───── Motion ─────┤
│ _s_: Window        │
│ _S_: Tabs          │
│ _w_: Save file     │
│ _q_: Close file    │
│ _Q_: Close all     │
│ _v_: Select pasted │
│ _/_: Clear search  │
├──────────────────┤
│ _x_: Quit          │
└──────────────────┘
]]

Hydra({
    name = 'Files',
    hint = hintLeader,
    config = colors.passAllow(),
    mode = '',
    body = '\\',
    heads = {
        { 'f', callback.hydraCallback('files') },
        { 't', callback.hydraCallback('text') },

        { 'l', callback.hydraCallback('lsp') },
        { 'g', callback.hydraCallback('git') },
        { 'b', callback.hydraCallback('build') },

        { 'p', callback.hydraCallback('packages') },
        { 'd', cmd 'Alpha' }, 

        { 'c', callback.hydraCallback('config') },
        { 'o', callback.hydraCallback('options') },
        { 'h', callback.hydraCallback('manual') }, 

        { 's', callback.hydraCallback('window') },
        { 'S', callback.hydraCallback('tabs') },
        { 'w', cmd 'update' },
        { 'q', cmd 'x' },
        { 'Q', cmd 'qa!' },
        { 'v', "printf('`[%s`]', getregtype()[0])", { expr = true } },
        { '/', ':nohl<cr>:lua MiniMap.refresh()<cr>' },

        { 'x', nil, { exit = true, nowait = true } },
        { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
        { '\\', nil, { exit = true, nowait = true, desc = false } },
    }
})

-- -------------------------------------------------------------------------- --

-- ┌───────────────────────────────────────────────┐
-- │	─	│	┌	┐	└	┘	├	┤	┬	┴	┼	│
-- │												│
-- │	═	║	╔	╗	╚	╝	╠	╣	╦	╩	╬	│
-- └───────────────────────────────────────────────┘

-- ┌───────────────────────────────────────────────────────────────────┐
-- │	─	━	│	┃	┄	┅	┆	┇	┈	┉	┊	┋	┌	┍	┎	┏	│
-- │	┐	┑	┒	┓	└	┕	┖	┗	┘	┙	┚	┛	├	┝	┞	┟	│
-- │	┠	┡	┢	┣	┤	┥	┦	┧	┨	┩	┪	┫	┬	┭	┮	┯	│
-- │	┰	┱	┲	┳	┴	┵	┶	┷	┸	┹	┺	┻	┼	┽	┾	┿	│
-- │	╀	╁	╂	╃	╄	╅	╆	╇	╈	╉	╊	╋	╌	╍	╎	╏	│
-- │	═	║	╒	╓	╔	╕	╖	╗	╘	╙	╚	╛	╜	╝	╞	╟	│
-- │	╠	╡	╢	╣	╤	╥	╦	╧	╨	╩	╪	╫	╬	╭	╮	╯	│
-- │	╰	╱	╲	╳	╴	╵	╶	╷	╸	╹	╺	╻	╼	╽	╾	╿	│
-- └───────────────────────────────────────────────────────────────────┘

-- ┌────────────────────────┐
-- │	Upper half:		▀	 │
-- │	Lower half:		▄	 │
-- │						 │
-- │	Solid Block:	█	 │
-- │						 │
-- │	Light Block: 	░	 │
-- │	Medium Block: 	▒	 │
-- │	Dark Block: 	▓	 │
-- └────────────────────────┘
