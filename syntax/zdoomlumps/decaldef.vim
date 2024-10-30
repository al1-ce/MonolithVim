
call zdoomlump#syn_word('lmpLocalKeyword', '')
hi def link lmpLocalKeyword Keyword

call zdoomlump#syn_word('lmpLocalSpecial', '')
hi def link lmpLocalSpecial Special

syn keyword lmpDefinitions decal animator decalgroup generator combiner

syn keyword lmpDefinitions animatortype
syn keyword lmpProperties
                        \ pic shade flipx flipy randomflipx randomflipy solid opaqueblood translucent
                        \ add fuzzy fullbright lowerdecal colors animator

syn keyword lmpDefinitions fader
syn keyword lmpProperties decaystart decaytime

syn keyword lmpDefinitions stretcher
syn keyword lmpProperties goalx goaly stretchstart stretchtime

syn keyword lmpDefinitions slider
syn keyword lmpProperties distx disty slidestart slidetime

syn keyword lmpDefinitions colorchanger
syn keyword lmpProperties color fadestart fadetime

call zdoomlump#syn_line("lmpProperties", "x-scale y-scale")

hi def link lmpDefinitions Macro
hi def link lmpProperties Delimiter


