
call zdoomlump#syn_word('lmpLocalKeyword', 'before noportrait centered clean protected')
hi def link lmpLocalKeyword Keyword

syn keyword lmpDefinitions DefaultListMenu OptionValue OptionString

syn keyword lmpDefinitions ListMenu AddListMenu
syn keyword lmpProperties
                        \ Class NetgameMessage Font Linespacing CenterMenu PlayerDisplay Position
                        \ Selector TextItem PatchItem StaticText StaticTextCentered StaticPatch
                        \ StaticPatchCentered CpationItem Size AnimatedTransition Animated MouseWindow
                        \ ForceList

syn keyword lmpDefinitions DefautOptionMenu OptionMenu AddOptionMenu
syn keyword lmpProperties
                        \ Class Title Caption Position DefaultSelection ScrollTop StaticText
                        \ StaticTextSwitchable AnimatedTransition Animated
                        \ Control MapControl Option FlagOption ColorPicker Slider ScaleSlider
                        \ TextField NumberField
                        \ SubMenu LabeledSubmenu Command SafeCommand

syn keyword lmpDefinitions ImageScroller
syn keyword lmpProperties
                        \ Class AnimatedTransition Animated TextBackground TextBackgroundBrightness
                        \ TextScale TextFont TextItem ImageItem

call zdoomlump#syn_line("lmpLocalFunction", "ifgame ifnotgame ifoption else")
call zdoomlump#syn_word("lmpLocalFunction", "ifgame ifnotgame ifoption else")
hi def link lmpLocalFunction Macro

hi def link lmpDefinitions Macro
hi def link lmpProperties Delimiter


