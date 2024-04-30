" Vim syntax file
" Language:     Factorio Assembly
" Maintainer:   al1-ce (aka silyneko)
" Version:      1.0.0
" Last Change:  2024
" URL:          none
" License:      MIT

if exists("b:current_syntax")
  finish
endif

syn match fasmComment "#.*$"
syn match fasmDirective "^\s*[a-zA-Z]\+"
syn match fasmNumber "\-\=[0-9]\+"
syn match fasmReg "\sr\(eg\)\=@\=[0-9]\+"
syn match fasmReg "\sred@\=[0-9]*"
syn match fasmReg "\sgreen@\=[0-9]*"
syn match fasmReg "\sm\(em\)\=[0-9]\+\(\[[0-9]\+\]\)\="
syn match fasmReg "\sout[0-9]*"
syn match fasmReg "\slogi"
syn match fasmReg "\slogi\(\[[0-9]\+\]\)\="

syn match fasmItemLabel "\[.*=.*\]"
syn match fasmString "\'.*\'"

" syn match fasmLabel "^:[a-zA-Z0-9_.]"

syn match fasmLabelName ":[a-zA-Z0-9_\.]\+"

let b:current_syntax = "fasm"
" hi def link fasmSpecial Special
" hi def link fasmTodo Todo
hi def link fasmComment Comment
hi def link fasmLabelName Label
" hi def link fasmAddrLabel Label
hi def link fasmDirective Function
" hi def link fasmDirective Macro
" hi def link fasmOp Function
" hi def link fasmMicroOp Function
" hi def link fasmMacroArg Special
" hi def link fasmReg Special
hi def link fasmReg Identifier
hi def link fasmNumber Number
" hi def link fasmString String
" hi def link fasmLabelName String
hi def link fasmItemLabel String
hi def link fasmString String
