" Vim syntax file
" Language:     Lump
" Maintainer:   Alisa Lain <al1-ce@null.net>
" Filenames:    *.lmp
" URL:          none

if exists('b:current_syntax')
    finish
endif

sy case ignore

syn keyword lmpTodo contained TODO FIXME XXX
syn match lmpLineComment "//.*$" contains=lmpTodo,@Spell
syn region lmpBlockComment start="/\*" end="\*/" contains=lmpTodo,@Spell
syn cluster lmpComment contains=lmpLineComment,lmpBlockComment

let g:zdoomlump_defined = get(g:, 'zdoomlump_defined', 0)
if g:zdoomlump_defined == 0
    let g:zdoomlump_defined = 1
    function! zdoomlump#syn_word(group, kwords)
        execute "syn match " . a:group . ' "\s\+\zs\(' . substitute(a:kwords, " ", "\\\\|", "g") . '\)\ze\(\s\+\|$\)"'
    endfunction

    function! zdoomlump#syn_line(group, kwords)
        execute "syn match " . a:group . ' "^\s*\(' . substitute(a:kwords, " ", "\\\\|", "g") . '\)\>"'
    endfunction
endif

" Load specific lump syntax
for path in split(&runtimepath, ",")
    let s:fname_full = tolower(expand("%:t"))
    let s:fname_crop = tolower(expand("%:t:r"))
    if s:fname_crop == "hirestex"
        let s:fname_full = "textures"
        let s:fname_crop = "textures"
    endif
    if s:fname_crop == "zmapinfo"
        let s:fname_full = "mapinfo"
        let s:fname_crop = "mapinfo"
    endif
    if filereadable(path . "/syntax/zdoomlumps/" . s:fname_full . ".vim")
        execute "source " . path . "/syntax/zdoomlumps/" . s:fname_full . ".vim"
    endif
    if filereadable(path . "/syntax/zdoomlumps/" . s:fname_crop . ".vim")
        execute "source " . path . "/syntax/zdoomlumps/" . s:fname_crop . ".vim"
    endif
endfor

syn keyword lmpKeyword include

syn match lmpInteger "\<\d\+\%(_\+\d\+\)*\>" display
syn match lmpInteger "\<0x[[:xdigit:]_]*\x\>" display
syn match lmpReal "\<\d\+\%(_\+\d\+\)*\.\d\+\%(_\+\d\+\)*\%([Ee][-+]\=\d\+\%(_\+\d\+\)*\)\=" display
syn match lmpReal "\<\d\+\%(_\+\d\+\)*[Ee][-+]\=\d\+\%(_\+\d\+\)*\>" display
syn cluster lmpNumber contains=lmpInteger,lmpReal

syn keyword lmpBoolean true false

syn match lmpSpecialError "\\." contained
syn match lmpSpecialCharError "[^']" contained
syn match lmpSpecialChar +\\["\\'nrt]+ contained display
syn match lmpCharacter "'[^']*'" contains=lmpSpecialChar,lmpSpecialCharError display
syn match lmpCharacter "'\\''" contains=lmpSpecialChar display
syn match lmpCharacter "'[^\\]'" display
syn region lmpString matchgroup=lmpQuote start=+"+ end=+"+ end=+$+ extend contains=lmpSpecialChar,lmpSpecialError,@Spell

syn cluster lmpString contains=lmpString,lmpInterpolatedString
syn cluster lmpLiteral contains=lmpBoolean,lmpNull,@lmpNumber,lmpCharacter,@lmpString

syn match lmpParens "[()]" display
syn region lmpBracketed matchgroup=lmpParens start=+(+ end=+)+ extend contained transparent contains=@lmpAll,lmpBraced,lmpBracketed
syn region lmpBraced matchgroup=lmpParens start=+{+ end=+}+ extend contained transparent contains=@lmpAll,lmpBraced,lmpBracketed

" The default highlighting.

hi def link lmpTodo Todo
hi def link lmpLineComment Comment
hi def link lmpBlockComment Comment

hi def link lmpKeyword Keyword

hi def link lmpBoolean Boolean
hi def link lmpInteger Number
hi def link lmpReal Float
hi def link lmpCharacter Character
hi def link lmpString String
hi def link lmpQuote String

hi def link lmpSpecialError Error
hi def link lmpSpecialCharError Error
hi def link lmpSpecialChar SpecialChar

hi def link lmpInterpolationDelimiter Delimiter
hi def link lmpInterpolationAlignDel lmpInterpolationDelimiter
hi def link lmpInterpolationFormat lmpInterpolationDelimiter
hi def link lmpInterpolationFormatDel lmpInterpolationDelimiter
hi def link lmpInterpolatedString String

let b:current_syntax = 'lmp'

" vim: vts=16,32


