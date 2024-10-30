
syn match lmpLocalHeader "\[.\+\]"
hi def link lmpLocalHeader Special

syn match lmpLocalSector "\$s\d\+\ze;"
hi def link lmpLocalSector Macro

syn match lmpLocalTrigger "\$t\d\+\ze;"
hi def link lmpLocalTrigger Function

syn match lmpLocalHintnr "#\d\+"
hi def link lmpLocalHintnr Number

