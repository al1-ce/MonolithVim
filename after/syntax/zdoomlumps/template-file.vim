
call zdoomlump#syn_word('lmpLocalKeyword', '')
hi def link lmpLocalKeyword Keyword

call zdoomlump#syn_word('lmpLocalSpecial', '')
hi def link lmpLocalSpecial Special

syn keyword lmpDefinitions
                        \ 
                        \ ______________END

syn keyword lmpProperties
                        \ 
                        \ ______________END

call zdoomlump#syn_line("lmpLocalFunction", "")
hi def link lmpLocalFunction Macro

call zdoomlump#syn_line("lmpProperties", "")

hi def link lmpDefinitions Macro
hi def link lmpProperties Delimiter

