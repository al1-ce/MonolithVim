" Vim syntax file
" Language: SDLang
" Maintainer: Alisa Lain
" Last Change: 2023 May 9 (09/06/2023)
" Links: https://sdlang.org
" Remarks: Layout based on asm.vim and d.vim from NeoVim v0.3.0 release

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case match

" boolean
syn keyword sdlangBool true false on off null
high def link sdlangBool Boolean

" tags
syn match sdlangTag /"\@![a-z][a-zA-Z._0-9$-]\+"\@!/
high def link sdlangTag Identifier

" numbers
syn match sdlangNum /[+-]\?\d\+\(L\|BD\)\?/
high def link sdlangNum Number
syn match sdlangFloat /[+-]\?\d\+\.\d\+\(f\|d\)\?/
high def link sdlangFloat Float

" date/time and duration
syn match sdlangDate /\d\{4}\/\d\{2}\/\d\{2}/ nextgroup=sdlangTime skipwhite
syn match sdlangTime /\d\{2}\:\d\{2}\:\d\{2}\.\d\{3}\(-UTC\)\?/
syn match sdlangDuration /\(\d\+d:\)\?\d\{2}\:\d\{2}\:\d\{2}\(\.\d\{3}\)\?/
high def link sdlangDate Constant
high def link sdlangTime Constant
high def link sdlangDuration Constant

" base64 data
" syn match sdlangBase64 /\[[a-zA-Z0-9+/]*\]/
" high def link sdlangBase64 Constant
syn region sdlangBase64 start=+\[+ end=+\][cwd]\=+
high def link sdlangBase64 Constant

" strings
syn region sdlangString start=+"+ end=+"[cwd]\=+ skip=+\\\\\|\\"+
syn region sdlangString start=+'+ end=+'[cwd]\=+ skip=+\\\\\|\\"+
syn region sdlangRawString start=+`+ end=+`[cwd]\=+
high def link sdlangString String
high def link sdlangRawString String

" generic value type - contains all of the above
syn cluster sdlangValue contains=sdlangNum,sdlangFloat,sdlangString,sdlangBool,sdlangDate,sdlangTime,sdlangDuration,sdlangBase64

" comments
" syn match sdlangComment /\/\/.*$/
" syn match sdlangComment /--.*$/
" syn match sdlangComment /#.*$/
" syn match sdlangComment /\/\*\_.\{-}\*\//

" Comments
"
syn match sdlangCommentError display "\*/"
syn match sdlangNestedCommentError display "+/"

syn match sdlangCommentStar contained "^\s*\*[^/]"me=e-1
syn match sdlangCommentStar contained "^\s*\*$"
syn match sdalngCommentPlus contained "^\s*+[^/]"me=e-1
syn match sdlangCommentPlus contained "^\s*+$"

syn region sdlangBlockComment start="/\*" end="\*/" contains=sdlangCommentStartError,@Spell fold
syn region sdlangNestedComment start="/+" end="+/" contains=sdlangNestedComment,@Spell fold
syn match sdlangLineComment "//.*"
syn match sdlangLineComment "#.*"
syn match sdlangLineComment "--.*"

hi link dCommentStar dBlockComment
hi link dCommentPlus dNestedComment

syn sync minlines=200
syn sync ccomment dBlockComment

high def link sdlangLineComment Comment
high def link sdlangBlockComment Comment
high def link sdlangNestedComment Comment

" attributes
syn match sdlangAttribute /"\@![a-z][a-zA-Z._]\+"\@!=/ nextgroup=sdlangValue

let b:current_syntax = "sdlang"

" vim: ts=4
