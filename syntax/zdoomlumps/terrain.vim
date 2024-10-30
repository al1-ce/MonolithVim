
syn keyword lmpDefinitions
                        \ Terrain floor defaultterrain splash
                        \ ______________END

syn keyword lmpProperties
                        \ Footclip Liquid Friction DamageType DamageAmount DamageTimeMask
                        \ DamageOnLand AllowProtection LeftStepSounds RightStepSounds StepSounds
                        \ StepDistance StepDistanceMinVel WalkStepTics RunStepTics
                        \ SmallClass SmallClip SmallSound BaseClass ChunkBaseZVel ChunkClass
                        \ ChunkXVelShift ChunkYVelShift ChunkZVelShift Sound noalert

hi def link lmpDefinitions Macro
hi def link lmpProperties Delimiter


