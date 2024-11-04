" Vim syntax file
" Language: JSL
" Maintainer: Alisa Lain
" Latest Revision: 7 June 2023

" TODO: line 62
" TODO: line 69
" TODO: line 141
" TODO: highlight line break with \
" TODO: line 143, possibly highlight literal strings as string
" TODO: line 174, possibly highlight ! symbol
" TODO: possibly highlight = {} :

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case match

"syn match jslError "."

" boolean
syn keyword jslBool true false on off null

syn match jslPropertyAuto /"\@!!\?\([a-zA-Z_][a-zA-Z._0-9$-]*:\)\?[a-zA-Z_][a-zA-Z._0-9$-]*"\@!/ contains=jslNamespaceBreak,jslNot

" tags
syn match jslTag /\(^\|;\|{\|}\)\@<=\s*"\@!\([a-zA-Z_][a-zA-Z._0-9$-]*:\)\?[a-zA-Z_][a-zA-Z._0-9$-]*"\@!/ contains=jslNamespaceBreak

syn match jslNamespaceBreak ":" contained
syn match jslTagBreak ";"
syn match jslEquals "=" contained
syn match jslNot "!" contained

" numbers
syn match jslNum /[+-]\?\d\+\(l\|L\)\?/
syn match jslFloat /[+-]\?\d\+\.\d\+\(f\|F\|d\|D\|bd\|BD\)\?/

" Floating point like number with E and no decimal point (+,-)
syn match jslNumber '[-+]\=\d[[:digit:]]*[eE][\-+]\=\d\+' contained display
syn match jslNumber '\d[[:digit:]]*[eE][\-+]\=\d\+' contained display

" Floating point like number with E and decimal point (+,-)
syn match jslNumber '[-+]\=\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+' contained display
syn match jslNumber '\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+' contained display

" SDLang date/time and duration
" yyyy/mm/dd
syn match jslDate /\d\{4}\/\d\{2}\/\d\{2}/ nextgroup=jslTime skipwhite
" hh:mm(:ss)(.xxx)(-ZONE)
syn match jslTime /\d\{2}\:\d\{2}\:\d\{2}\.\d\{3}\(-\a\{1,6}\)\?/
" (-)(d:)hh:mm:ss(.xxx)
syn match jslDuration /\(-\)\?\(\d\+d:\)\?\d\{2}\:\d\{2}\:\d\{2}\(\.\d\{3}\)\?/
" JSL date/time and duration
" dd/mm/yyyy
syn match jslDate /\d\{2}\/\d\{2}\/\d\{4}/
" dd.mm.yy(yy)
syn match jslDate /\d\{2}\.\d\{2}\.\d\{2}\(\d\{2}\)\?/
" YYYY-MM-DD(THH:MM:SS)
syn match jslDate /\d\{4}-\d\{2}-\d\{2}\(T\d\{2}\:\d\{2}\:\d\{2}\)\?/

" TODO: make contained in node if to do proper node syntax?
syn match jslChildrenBraces "{"
syn match jslChildrenBraces "}"
" syn region jslChildren start="{" end="}" transparent fold keepend

" base64 data
syn match jslBase64 /\[\([a-zA-Z0-9+/]\|\n\|\r\|\s\|\r\)*\]/
" high def link jslBase64 Constant
" syn region jslBase64 start=+\[+ end=+\]+

" strings
syn match jslEscape +\\\('\|"\|?\|\\\|0\|a\|b\|f\|n\|r\|t\|v\)+ contained
syn match jslEscape +\\x[a-zA-Z0-9]\{2}+ contained
syn match jslEscape +\\[0-7]\{1,3}+ contained
syn match jslEscape +\\u[a-zA-Z0-9]\{4}+ contained
syn match jslEscape +\\U[a-zA-Z0-9]\{8}+ contained
syn match jslEscape "\\&\w\+;" contained
syn region jslString start=+"+ end=+"+ contains=jslStringLinebreak,jslEscape skip=+\\"+
syn region jslString start=+'+ end=+'+ contains=jslStringLinebreak,jslEscape skip=+\\'+
syn region jslRawString start=+`+ end=+`+
syn match jslLiteralString /=\@<="\@!\([a-zA-Z_][a-zA-Z._0-9$-]*:\)\?[a-zA-Z_][a-zA-Z._0-9$-]*"\@!/

" generic value type - contains all of the above
syn cluster jslValue contains=jslNum,jslFloat,jslString,jslRawString,jslBool,jslDate,jslTime,jslDuration,jslBase64,jslLiteralString

" attributes
syn match jslAttribute /"\@!\([a-zA-Z_][a-zA-Z._0-9$-]*:\)\?[a-zA-Z_][a-zA-Z._0-9$-]*"\@!=/ contains=jslEquals,jslNamespaceBreak nextgroup=jslValue

" special line break
" syn match jslLinebreak "\\\s*\(\(//\|#\|--\).*\)\?\s*$" contains=jslLineComment keepend
syn region jslLinebreak start="\\\s*\(\(//\|#\|--\).*\)\?\s*$" end="^\s*" contains=jslLineComment keepend nextgroup=jslPropertyAuto,jslValue,jslTag
syn match jslStringLinebreak "\\\s*\(\(//\|#\|--\).*\)\?\s*$" contains=jslLineComment keepend contained

" comments
" syn match jslComment /\/\/.*$/
" syn match jslComment /--.*$/
" syn match jslComment /#.*$/
" syn match jslComment /\/\*\_.\{-}\*\//

" Comments
"
syn match jslCommentError display "\*/"
syn match jslNestedCommentError display "+/"

syn match jslCommentStar contained "^\s*\*[^/]"me=e-1
syn match jslCommentStar contained "^\s*\*$"
syn match jslCommentPlus contained "^\s*+[^/]"me=e-1
syn match jslCommentPlus contained "^\s*+$"

syn region jslBlockComment start="/\*" end="\*/" contains=jslCommentStartError,@Spell fold
syn region jslNestedComment start="/+" end="+/" contains=jslNestedComment,@Spell fold
syn match jslLineComment "//.*"
syn match jslLineComment "#.*"
syn match jslLineComment "--.*"

syn match jslDateComment /\d\{4}\/\d\{2}\/\d\{2}\( \d\{2}\:\d\{2}\:\d\{2}\.\d\{3}\(-\a\{1,6}\)\?\)\?/ transparent contained
syn region jslStringComment start=+"+ end=+"+ transparent contains=jslLinebreakComment skip=+\\"+ contained
syn region jslStringComment start=+'+ end=+'+ transparent contains=jslLinebreakComment skip=+\\'+ contained
syn region jslStringComment start=+`+ end=+`+ transparent contained keepend
syn region jslChildrenComment start="{" end="}"me=e-1 fold transparent contained keepend
syn match jslLinebreakComment "\\\s*$" transparent contains=jslLineComment keepend containedin=jslNodeComment contained

" node /-value /-attrib=val
syn match jslNodeComment "\s\+\/-.\{-}\s"me=e-1 contains=jslLinebreakComment,jslStringComment,jslDateComment fold
" /-node ...
syn region jslNodeComment start="^\s*\/-" end="[$};]" contains=jslLinebreak,jslChildrenComment fold
" node /-{ children }
syn region jslNodeComment start="\s\+\/-{" end="}" fold

syn cluster jslComment contains=jslLineComment,jslBlockComment,jslNestedComment,jslNodeComment

syn sync minlines=200

hi def link jslTag Define

hi def link jslBool Boolean
hi def link jslNum Number
hi def link jslFloat Float

hi def link jslDate Constant
hi def link jslTime Constant
hi def link jslDuration Constant
hi def link jslBase64 Constant

hi def link jslString String
hi def link jslRawString String
hi def link jslLiteralString String
hi def link jslEscape Special
hi def link jslLinebreak Special
hi def link jslStringLinebreak Special

hi def link jslChildrenBraces Delimiter
hi def link jslTagBreak Delimiter
hi def link jslNamespaceBreak Delimiter
hi def link jslEquals Delimiter
hi def link jslNot Delimiter

hi def link jslAttribute Identifier
" hi def link jslPropertyAuto Boolean
hi def link jslPropertyAuto Identifier

hi def link jslLineComment Comment
hi def link jslBlockComment Comment
hi def link jslNestedComment Comment
hi def link jslNodeComment Comment

"hi def link jslError Error
hi def link jslCommentError Error
hi def link jslNestedCommentError Error

setlocal! foldmethod=syntax

let b:current_syntax = "jsl"

" vim: ts=4


