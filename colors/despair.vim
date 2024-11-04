" Name: despair
" Author: Alisa Lain <al1-ce@null.net>
" Notes: Minimal dark colorscheme kind of based on austere

set background=dark
highlight clear
if exists("syntax on")
    syntax reset
endif

let g:colors_name = "despair"

" Background: dark
" Color: black         #101010 ~
" Color: darkgrey      #252525 ~
" Color: darkstone     #7c7c7c ~
" Color: almostwhite   #b9b9b9 ~
" Color: grey          #8e8e8e ~
" Color: white         #f7f7f7 ~
" Color: beige         #e3e3e3 ~
" Color: red           #ce5252 ~
" color: green         #9ca54e ~
" Color: blue          #5f819d ~
" Color: yellow        #f0c674 ~
" c0  #101010
" c1  #903a3a
" c2  #6d7144
" c3  #af8431
" c4  #50616f
" c5  #92729f
" c6  #61837e
" c7  #b9b9b9
" c8  #8e8e8e
" c9  #ce5252
" c10 #9ca54e
" c11 #f0c674
" c12 #5f819d
" c13 #b48ac4
" c14 #73b8af
" c15 #f7f7f7

" can set StatusLine's guibg to #252525 to have them pretty and colored
hi  Normal                   term=none               ctermfg=white     cterm=none      guifg=#b9b9b9 gui=none      guibg=#101010
hi  Comment                  term=none               ctermfg=darkgray  cterm=none      guifg=#6e6e6e gui=none      guibg=#101010
hi  CursorLine               term=none               ctermfg=gray      cterm=none      guifg=#e7e7e7 gui=none      guibg=#101010
hi  CursorLineNr             term=none               ctermfg=gray      cterm=none      guifg=#f7f7f7 gui=none      guibg=#101010
hi  LineNr                   term=none               ctermfg=gray      cterm=none      guifg=#b9b9b9 gui=none      guibg=#101010
hi  Number                   term=bold               ctermfg=blue      cterm=none      guifg=#5f819d gui=bold      guibg=#101010
hi  Operator                 term=bold               ctermfg=white     cterm=bold      guifg=#b9b9b9 gui=bold      guibg=#101010
hi  Pmenu                    term=none               ctermfg=white     cterm=none      guifg=#b9b9b9 gui=none      guibg=#252525
hi  PmenuSbar                term=none               ctermfg=white     cterm=none      guifg=#b9b9b9 gui=none      guibg=#252525
hi  PmenuSel                 term=bold               ctermfg=white     cterm=bold      guifg=#f7f7f7 gui=bold      guibg=#252525
hi  PmenuThumb               term=none               ctermfg=white     cterm=none      guifg=#b9b9b9 gui=none      guibg=#101010
hi  SignColumn               term=none               ctermfg=darkgray  cterm=none      guifg=#8e8e8e gui=none      guibg=#101010
hi  Special                  term=none               ctermfg=white     cterm=bold      guifg=#b9b9b9 gui=bold      guibg=#101010
hi  Statement                term=bold               ctermfg=white     cterm=bold      guifg=#b9b9b9 gui=bold      guibg=#101010
hi  String                   term=none               ctermfg=darkgreen cterm=none      guifg=#9ca54e gui=none      guibg=#101010
hi  Type                     term=bold               ctermfg=white     cterm=none      guifg=#b9b9b9 gui=none      guibg=#101010
hi  VertSplit                term=none               ctermfg=black     cterm=none      guifg=#101010 gui=none      guibg=#101010
hi  Visual                   term=none               ctermfg=none      cterm=reverse   guifg=none    gui=reverse   guibg=none
hi  VisualNOS                term=none               ctermfg=white     cterm=none      guifg=#b9b9b9 gui=none      guibg=#252525
hi  DiagnosticUnderlineError term=underline          ctermfg=white     cterm=underline guifg=#b9b9b9 gui=underline guibg=#101010 guisp=none
hi  ExtraWhitespace          term=underline          ctermfg=red       cterm=underline guifg=#ce5253 gui=underline guibg=#2f1515
hi  Error                    term=none               ctermfg=red       cterm=none      guifg=#101010 gui=none      guibg=#ce5252
"hi  StatusLine               term=none               ctermfg=white    cterm=underline guifg=#b9b9b9 gui=underline guibg=#101010
"hi  StatusLineNC             term=none               ctermfg=darkgray cterm=underline guifg=#6e6e6e gui=underline guibg=#101010
hi! link                     DiagnosticUnderlineHint DiagnosticUnderlineError
hi! link                     DiagnosticUnderlineInfo DiagnosticUnderlineError
hi! link                     DiagnosticUnderlineOk   DiagnosticUnderlineError
hi! link                     DiagnosticUnderlineWarn DiagnosticUnderlineError
hi! link                     @module.d               Normal
hi! link                     @variable               Normal
hi! link                     Boolean                 Normal
hi! link                     Character               String
hi! link                     ColorColumn             Normal
hi! link                     Conditional             Normal
hi! link                     Constant                Normal
hi! link                     CursorColumn            Normal
hi! link                     Debug                   Normal
hi! link                     Define                  Normal
hi! link                     Delimiter               Normal
hi! link                     Directory               Normal
hi! link                     Exception               Normal
hi! link                     Float                   Number
hi! link                     Question                Number
hi! link                     FloatBorder             Normal
hi! link                     Function                Normal
hi! link                     Identifier              Normal
hi! link                     Include                 Normal
hi! link                     Keyword                 Normal
hi! link                     Label                   Normal
hi! link                     Macro                   Normal
hi! link                     MatchParen              Normal
hi! link                     NormalFloat             Normal
hi! link                     PreProc                 Normal
hi! link                     Precondit               Normal
hi! link                     Repeat                  Normal
hi! link                     Special                 Normal
hi! link                     SpecialChar             Normal
hi! link                     Statement               Normal
hi! link                     StatusLine              Normal
hi! link                     StatusLineNC            Normal
hi! link                     StatusLineTerm          Normal
hi! link                     StatusLineTermNC        Normal
hi! link                     StorageClass            Normal
hi! link                     Tabline                 Normal
hi! link                     TablineFill             Normal
hi! link                     TablineSel              Normal
hi! link                     Tag                     Normal
hi! link                     Terminal                Normal
hi! link                     Title                   Normal
hi! link                     Todo                    Normal
hi! link                     Type                    Normal
hi! link                     Typedef                 Normal
hi! link                     WinSeparator            Comment
hi! link                     cParenError             Normal
hi! link                     luaParenError           Normal
hi! link                     luaError                Normal
hi! link                     TodoFgWARN              Normal
hi! link                     TodoFgTODO              Normal
hi! link                     TodoFgTEST              Normal
hi! link                     TodoFgPERF              Normal
hi! link                     TodoFgNOTE              Normal
hi! link                     TodoFgLINK              Normal
hi! link                     TodoFgHACK              Normal
hi! link                     TodoFgFIX               Normal

