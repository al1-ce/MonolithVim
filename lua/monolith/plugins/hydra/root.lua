local Hydra = require('hydra')

-- https://github.com/anuvyklack/hydra.nvim

local cmd = require('hydra.keymap-util').cmd

local callback = require('monolith.plugins.hydra.callback');
local colors = require('monolith.plugins.hydra.colors');

local hintLeader = [[
┌       Menu       ┐
  _f_: Files          
  _t_: Text/Term/Tab  
       Devenv       
  _l_: Lsp            
  _b_: Build          
        Misc        
  _p_: Package        
  _v_: View           
      Settings      
  _o_: Options        
  _h_: Help           
                    
  _q_: Quit           
└                  ┘
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
        { 'b', callback.hydraCallback('build') },

        { 'p', callback.hydraCallback('packages') },
        { 'v', callback.hydraCallback('view') },

        { 'o', callback.hydraCallback('options') },
        { 'h', callback.hydraCallback('manual') },

        { 'q', nil, { exit = true, nowait = true } },
        { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
        { '\\', nil, { exit = true, nowait = true, desc = false } },
    }
})

-- -------------------------------------------------------------------------- --

-- ┌                                               ┐
--  	 	 	┌	┐	└	┘	 	 	┬	┴	┼	 
--  												 
--  	═	║	╔	╗	╚	╝	╠	╣	╦	╩	╬	 
-- └                                               ┘

-- ┌                                                                   ┐
--  	 	━	 	┃	┄	┅	┆	┇	┈	┉	┊	┋	┌	┍	┎	┏	 
--  	┐	┑	┒	┓	└	┕	┖	┗	┘	┙	┚	┛	 	┝	┞	┟	 
--  	┠	┡	┢	┣	 	┥	┦	┧	┨	┩	┪	┫	┬	┭	┮	┯	 
--  	┰	┱	┲	┳	┴	┵	┶	┷	┸	┹	┺	┻	┼	┽	┾	┿	 
--  	╀	╁	╂	╃	╄	╅	╆	╇	╈	╉	╊	╋	╌	╍	╎	╏	 
--  	═	║	╒	╓	╔	╕	╖	╗	╘	╙	╚	╛	╜	╝	╞	╟	 
--  	╠	╡	╢	╣	╤	╥	╦	╧	╨	╩	╪	╫	╬	╭	╮	╯	 
--  	╰	╱	╲	╳	╴	╵	╶	╷	╸	╹	╺	╻	╼	╽	╾	╿	 
-- └                                                                   ┘

-- ┌                        ┐
--  	Upper half:		▀	  
--  	Lower half:		▄	  
--  						  
--  	Solid Block:	█	  
--  						  
--  	Light Block: 	░	  
--  	Medium Block: 	▒	  
--  	Dark Block: 	▓	  
-- └                        ┘

-- replace command %s/│\|─\|┤\|├/ /g

-- local hintLeader = [[
-- ┌────── Menu ──────┐
-- │ _f_: Files         │
-- │ _t_: Text/Term/Tab │
-- ├───── Devenv ─────┤
-- │ _l_: Lsp           │
-- │ _g_: Git           │
-- │ _b_: Build         │
-- ├────── Misc ──────┤
-- │ _d_: Dashboard     │
-- │ _p_: Package       │
-- │ _v_: View          │
-- ├──── Settings ────┤
-- │ _c_: Config/Dir    │
-- │ _o_: Options       │
-- │ _h_: Help          │
-- ├───── Motion ─────┤
-- │ _s_: Split         │
-- │ _w_: Save file     │
-- │ _W_: Force save    │
-- │ _q_: Close file    │
-- │ _Q_: Close all     │
-- │ _P_: Select pasted │
-- │ _/_: Clear search  │
-- ├──────────────────┤
-- │ _x_: Quit          │
-- └──────────────────┘
-- ]]
