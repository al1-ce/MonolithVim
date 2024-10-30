call zdoomlump#syn_word('lmpLocalKeyword', 'on off optional')
hi def link lmpLocalKeyword Keyword

call zdoomlump#syn_word('lmpLocalSpecial', 'pic sound tics rand texture allowdecals flat notrim oscillate')
call zdoomlump#syn_word('lmpLocalSpecial', 'fit worldpanning')
hi def link lmpLocalSpecial Special

syn keyword lmpDefinitions
                        \ range random
                        \ switch
                        \ warp
                        \ animateddoor opensound closesound
                        \ cameratexture
                        \ canvastexture
                        \ firetexture palette color
hi def link lmpDefinitions Macro

call zdoomlump#syn_line("lmpLocalFunction", "on off pic allowdecals texture flat")
hi def link lmpLocalFunction Macro


