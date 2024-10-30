
call zdoomlump#syn_word('lmpLocalKeyword', 'point surround world continuous random periodic custom linear log')
hi def link lmpLocalKeyword Keyword

call zdoomlump#syn_line("lmpLocalFunction", "$alias $ambient $archivepath $attenuation $edfoverride $ifdoom")
call zdoomlump#syn_line("lmpLocalFunction", "$ifheretic $ifhexen $ifstrife $limit $map $mididevice $modplayer")
call zdoomlump#syn_line("lmpLocalFunction", "$musicalias $musicvolume $pitchset $pitchshift $pitchshiftrange")
call zdoomlump#syn_line("lmpLocalFunction", "$playeralias $playercompat $playersound $playersounddup")
call zdoomlump#syn_line("lmpLocalFunction", "$random $registered $rolloff $singular $volume")
hi def link lmpLocalFunction Macro

hi def link lmpDefinitions Macro
hi def link lmpProperties Delimiter


