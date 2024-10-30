
syn keyword lmpDefinitions
                        \ iwad

syn keyword lmpProperties
                        \ name autoname iwadname supportwad config game mapinfo nokeyboardcheats
                        \ skipbexstringsiflanguage compatibility mustcontain
                        \ deletelumps bannercolors ignoretitlepatches load required startuptime
                        \ startupsong loadlights loadbrightmaps loadwidescreen discordappid steamappid

hi def link lmpDefinitions Macro
hi def link lmpProperties Delimiter


