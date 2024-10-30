
call zdoomlump#syn_word('lmpLocalKeyword', 'normal idle static none surround')
hi def link lmpLocalKeyword Keyword

syn keyword lmpDefinitions
                        \ end

syn keyword lmpProperties
                        \ play playuntildone playtime playrepeat playloop
                        \ delay delayonce delayrand
                        \ volume volumerel volumerand
                        \ attenuation
                        \ door platform environment stopsound nostopcutoff
                        \ slot randomsequence restart

syn match lmpDefinitions "^\s*\:\w\+"
syn match lmpDefinitions "^\s*\[\w\+"
syn match lmpDefinitions "^\s*\]"

hi def link lmpDefinitions Macro
hi def link lmpProperties Delimiter


