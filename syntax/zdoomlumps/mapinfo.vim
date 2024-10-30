
call zdoomlump#syn_word('lmpLocalKeyword', 'lookup teaser endpic endsequence')
hi def link lmpLocalKeyword Keyword

" call zdoomlump#syn_word('lmpLocalSpecial', '')
" hi def link lmpLocalSpecial Special

syn keyword lmpDefinitions Episode ClearEpisodes
syn keyword lmpProperties Name Lookup PicName Key Remove NoSkillMenu Optional Extended Intro

syn keyword lmpDefinitions Map DefaultMap AddDefaultMap GameDefaults
syn keyword lmpProperties
                        \ LevelNum WarpTrans Next SecretNext Slideshow DeathSequence Redirect CVAR_Redirect
                        \ Sky1 Sky2 Skybox DoubleSky ForceNoSkyStretch SkyStretch Fade FadeTable OutsideFog TitlePatch Par SuckTime
                        \ NoIntermission Music CDTrack CDId ExitPic EnterPic ExitAnim EnterAnim InterMusic BorderTexture Lightning
                        \ LightningSound EvenLightning SmoothLightning VertWallShade HorizWallShade TeamDamage Gravity NoGravity
                        \ AirControl AirSupply F1 MapBackground Translator AllowMonsterTelefrags ActivateOwnDeathSpecials
                        \ SpecialAction Map07Special BaronSpecial CyberdemonSpecial SpiderMastermindSpecial IronlichSpecial
                        \ MinotaurSpecial DSparilSpecial SpecialAction_ExitLevel SpecialAction_OpenDoor SpecialAction_LowerFloor
                        \ SpecialAction_KillMonsters ClipMidTextures NoAutoSequences AutoSequences StrictMonsterActivation
                        \ LaxMonsterActivation MissileShootersActivateImpactLines MissilesActivateImpactLines FallingDamage
                        \ OldFallingDamage ForceFallingDamage StrifeFallingDamage NoFallingDamage MonsterFallingDamage
                        \ ProperMonsterFallingDamage AvoidMelee FilerStarts AllowRespawn TeamPlayOn TeamPlayOff NoInventoryBar
                        \ KeepFullInventory InfiniteFlightPowerup NoJump AllowJump NoCrouch AllowCrouch NoFreelook AllowFreelook
                        \ NoInfighting NormalInfighting TotalInfighting CheckSwitchRange NoCheckSwitchRange UnFreezeSinglePlayerConversations
                        \ NoAllies NoSoundClipping ResetHealth ResetInventory ResetItems Grinding_Polyobj No_Grinding_Polyobj
                        \ DefaultEnvironment NoAutosaveHint UsePlayerStartZ RandomPlayerStarts
                        \ PrecacheSounds PrecacheTextures PrecacheClasses ForgetState RememberState SpawnWithWeaponRased
                        \ ForceFakeContrast ForceWorldPanning HazardColor HazardFlash PauseMusicInMenus EventHandlers NeedClusterText
                        \ NoClusterText Label Author EnableSkybooxAO DisableSkyboxAO EnableShadowmap DisableShadowmap AttenuateLights
                        \ NoFogOfWar SndInfo SoundInfo SndSeq Intro Outro
" OpenGL renderer only
syn keyword lmpProperties
                        \ FogDensity OutsideFogDensity SkyFog LightAdditiveSurfaces LightMode NoColoredSpriteLighting SkyRotate
                        \ PixelRatio NoLightFade

syn keyword lmpDefinitions Skill ClearSkills
syn keyword lmpProperties
                        \ AmmoFactor DropAmmoFactor DoubleAmmoFactor DamageFactor RespawnTime
                        \ RespawnLimit Aggressiveness SpawnFilter SpawnMulti SpawnMultiCoopOnly ASCReturn Key MustConfirm name PlayerClassName
                        \ PicName TextColor EasyBossBrain EasyKey FastMonsters SlowMonsters InstantReaction DisableCheats AutoUseHealth
                        \ ReplaceActor MonsterHealth FriendlyHealth NoPain DefaultSkill AmmoFactor NoInfighting TotalInfighting
                        \ HealthFactor KickbackFactor NoMenu PlayerRespawn

syn keyword lmpDefinitions GameInfo
syn keyword lmpProperties
                        \ AdvisoryTime Border
                        \ BackpackType BorderFlat ChatSound CreditPage AddCreditPage DefaultBloodColor DefaultBloodParticleColor
                        \ DrawReadThis FinaleFlat FinaleMusic FinalePage ForceTextInMenus InfoPage AddInfoPage IntermissionCounter
                        \ IntermissionMusic NightmareFast NoLoopFinaleMusic PageTime QuitSound SkyFlatName StatusBar TelefogHeight
                        \ TitleMusic TitlePage TitleTime Translator WeaponSlot ArmorIcons DimColor DimAmount DefInventoryMaxAmount
                        \ DefKickback DefaultRespawnTime DefaultDropStyle Endoom PickupColor QuitMessages AddQuitMessages
                        \ MenuFontColor_Title MenuFontColor_Label MenuFontColor_Value MenuFontColor_Action MenuFontColor_Header
                        \ MenuFontColor_Highlight MenuFontColor_Selection MenuSliderColor MenuSliderBackColor MenuBackButton PlayerClasses AddPlayerClasses
                        \ PauseSign GibFactor CursorPic SwapMneu TextScreenX TextScreenY DefaultEndSequence MapArrow NoRandomPlayerClass
                        \ DontCrunchCorpses CheatKey EasyKey ForceKillScripts PrecacheSounds PrecacheTextures PrecacheClasses
                        \ AddEventHandlers EventHandlers MessageBoxClass DefaultConversationMenuClass CorrectPrintBold
                        \ AltHudClass NoMergePickupMsg FullscreenAutoaspect StatusBarClass ForceNoGFXSubstitution BlurAmount
                        \ StatScreen_MapNameFont StatScreen_FinishedFont StatScreen_EnteringFont StatScreen_ContentFont
                        \ StatScreen_AuthorFont Dialogue AddDialogues StatScreen_Single StatScreen_Coop StatScreen_DM
                        \ NormSideMove NormForwardMove HideParTimes HelpMenuClass MenuDelegateClass Intro BasicArmorClass HexenArmorClass

syn keyword lmpDefinitions Intermission
syn keyword lmpProperties
                        \ Link Cast Fader GodoTitle Image Scroller TextScreen Wiper Background Draw DrawConditional
                        \ Music Sound Time CastClass CastName AttackSound FadeType BackGround2 InitialDelay ScrollDirection
                        \ ScrollTime Position Text TextColor TextDelay TextLump TextSpeed WipeType

syn keyword lmpDefinitions Automap Automap_Overlay
syn keyword lmpProperties
                        \ Base ShowLocks Background YourColor WallColor TwoSidedWallColor FloorDiffWallColor
                        \ CeilingDiffWallColor ExtraFloorWallColor ThingColor ThingColor_Item ThingColor_CountItem
                        \ ThingColor_Monster ThingColor_NoCountMonster ThingColor_Friend SpecialWallColor
                        \ SecretWallColor PortalColor GridColor XHairColor LockedColor IntraTeleportColor
                        \ InterTeleportColor SecretSectorColor AlmostBackgroundColor

syn keyword lmpDefinitions DoomEdNums SpawnNums ConversationIDs

syn keyword lmpDefinitions DamageType
syn keyword lmpProperties Factor ReplaceFactor NoArmor Obituary

syn keyword lmpDefinitions Cluster
syn keyword lmpProperties  EnterText ExitText ExitTextIsLump Music Flat Pic HUB AllowIntermission Intro Outro GameOver

call zdoomlump#syn_line("lmpProperties", "Cluster Intermission")

" call zdoomlump#syn_line("lmpLocalFunction", "")
" hi def link lmpLocalFunction Macro

syn match   lmpLocalMap "map\d\d"
syn match   lmpLocalMap "e\dm\d"
hi def link lmpLocalMap Special

hi def link lmpDefinitions Macro
hi def link lmpProperties Delimiter
