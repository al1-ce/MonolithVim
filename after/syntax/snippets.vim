" Syntax highlighting for .snippets files (used for snipMate.vim)
" Hopefully this should make snippets a bit nicer to write!
syn match snipComment '^#.*'
syn match placeHolder '\${\d\+\(:.\{-}\)\=}' contains=snipCommand
syn match tabStop '\$\d\+'
syn match snipEscape '\\\\\|\\`'
syn match snipCommand '\%(\\\@<!\%(\\\\\)*\)\@<=`.\{-}\%(\\\@<!\%(\\\\\)*\)\@<=`'
syn match snippet '^snippet.*' contains=multiSnipText,snipKeyword
syn match snippet '^extends.*' contains=snipKeyword
syn match snippet '^version.*' contains=snipKeyword
syn match snippet '^priority.*' contains=snipKeyword
syn match multiSnipText '\S\+ \zs.*' contained
syn match snipKeyword '^(snippet|extends|version|priority)'me=s+8 contained
syn match snipError "^[^#vsep\t ].*$"

syn region choice start='\${\d\+|' end='|}' contains=choiceValue
syn match choiceValue '[|,]\zs[^,|]\+\ze[|,]' contained

syn match transform '\${\d\+/.\{-}/.\{-}/\=}'

hi link snippet       Define
hi link snipComment   Comment
hi link multiSnipText String
hi link snipKeyword   Keyword
hi link snipEscape    SpecialChar
hi link placeHolder   Special
hi link choice        Special
hi link choiceValue   Keyword
hi link transform     Special
hi link tabStop       Special
hi link snipCommand   String
hi link snipError     Error
