-- for D: https://github.com/SirSireesh/vim-dlang-phobos-highlighter/blob/master/after/syntax/d.vim
-- ditto: https://github.com/neovim/neovim/blob/master/runtime/syntax/d.vim

local g = vim.g -- global variables
g.gruvbox_contrast_dark = "medium"
g.gruvbox_transparent_bg = 1
g.gruvbox_baby_transparent_mode = 1

vim.cmd.colorscheme('gruvbox')

vim.cmd[[
autocmd BufEnter *.d,
    \*.c,*.h,
    \*.cpp,*.hpp,
    \*.cs,*.java,*.class,*.kt,*.kts,*.ktm,
    \*.dart,*.js,*.ts,*.jspp,*.jpp,
    \*.py,*.lua,*.swift,*.go,
    \*.rs,*.rlib,*.hx,*.r,*.rb
    \ syn match   dCustomFunc     "\w\+\s*(\@="
hi def link dCustomFunc Function

hi! link LspSagaCodeActionBorder  LspSagaDiagnosticBorder
hi! link LspSagaLspFinderBorder  LspSagaDiagnosticBorder
hi! link FinderSpinnerBorder  LspSagaDiagnosticBorder
hi! link DefinitionBorder  LspSagaDiagnosticBorder
hi! link LspSagaHoverBorder  LspSagaDiagnosticBorder
hi! link LspSagaRenameBorder  LspSagaDiagnosticBorder
hi! link LspSagaSignatureHelpBorder  LspSagaDiagnosticBorder
hi! link LSOutlinePreviewBorder  LspSagaDiagnosticBorder
hi! link LspsagaGroupName  LspSagaDiagnosticBorder
hi! link LspSagaDiagnosticError  LspSagaDiagnosticBorder
]]

vim.cmd([[ 
execute 'let style_normal="cterm=NONE gui=NONE ctermfg=15 ctermbg=0 guifg=' . g:terminal_color_{15} . ' guibg=' . g:terminal_color_{0} . '"'
" execute 'let style_normal="cterm=NONE gui=NONE ctermfg=15 ctermbg=0 guifg=' . g:terminal_color_{15} . ' guibg=' . g:terminal_color_{0} . '"'
execute 'let style_function="cterm=NONE gui=NONE ctermfg=12 guifg=' . g:terminal_color_{12} . '"'
execute 'let style_keyword="cterm=NONE gui=NONE ctermfg=9 guifg=' . g:terminal_color_{9} . '"'
execute 'let style_type="cterm=italic gui=italic ctermfg=9 guifg=' . g:terminal_color_{9} . '"'
execute 'let style_const="cterm=NONE gui=NONE ctermfg=13 guifg=' . g:terminal_color_{13} . '"'
execute 'let style_string="cterm=NONE gui=NONE ctermfg=10 guifg=' . g:terminal_color_{10} . '"'
execute 'let style_macro="cterm=NONE gui=NONE ctermfg=14 guifg=' . g:terminal_color_{14} . '"'
execute 'let style_identifier="cterm=NONE gui=NONE ctermfg=15 guifg=#d5c4a1"'
execute 'let style_special="cterm=NONE gui=NONE ctermfg=11 guifg=#fe8019"'
execute 'let style_tag="cterm=NONE gui=NONE ctermfg=7 guifg=#7c6f63"'
execute 'let style_comment="cterm=italic gui=italic ctermfg=7 guifg=#7c6f63"'

execute 'let style_sign_warning="cterm=NONE gui=NONE ctermbg=11 guibg=#352C28"'
execute 'let style_sign_error="cterm=NONE gui=NONE ctermbg=1 guibg=#302828"'
execute 'let style_sign_warningfg="cterm=NONE gui=NONE ctermfg=11 ctermbg=3 guibg=#352C28 guifg=#fe8019"'
execute 'let style_sign_errorfg="cterm=NONE gui=NONE ctermfg=9 ctermbg=1 guibg=#302828 guifg=#fb4934"'
execute 'let style_sign_breakpoint="cterm=NONE gui=NONE ctermbg=4 guibg=#282830"'
execute 'let style_sign_breakpointfg="cterm=NONE gui=NONE ctermfg=12 ctermbg=4 guibg=#283030 guifg=#83a598"'

execute 'hi Normal ' . style_normal
execute 'hi NormalFloat ' . style_normal
execute 'hi FloatBorder ' . style_normal

execute 'hi Function ' . style_function

execute 'hi Identifier ' . style_identifier
execute 'hi Structure ' . style_identifier
execute 'hi Delimiter ' . style_identifier
execute 'hi Label ' . style_identifier

execute 'hi Conditional ' . style_keyword
execute 'hi Debug ' . style_keyword
execute 'hi Exception ' . style_keyword
execute 'hi Include ' . style_keyword
execute 'hi Repeat ' . style_keyword
execute 'hi StorageClass ' . style_keyword
execute 'hi Structure ' . style_keyword
execute 'hi Typedef ' . style_keyword
execute 'hi Keyword ' . style_keyword
execute 'hi Operator ' . style_keyword

execute 'hi Statement ' . style_type
execute 'hi Type ' . style_type

execute 'hi Constant ' . style_const
execute 'hi Boolean ' . style_const
execute 'hi Number ' . style_const
execute 'hi Float ' . style_const

execute 'hi String ' . style_string
execute 'hi Character ' . style_string

execute 'hi Special ' . style_special
execute 'hi SpecialChar ' . style_special

execute 'hi PreProc ' . style_macro
execute 'hi Define ' . style_macro
execute 'hi Macro ' . style_macro
execute 'hi Precondit ' . style_macro

execute 'hi Todo ' . style_tag
execute 'hi Tag ' . style_tag

execute 'hi Comment ' . style_comment

" Common
hi Search guifg=none guibg=none gui=reverse

" PQF
execute 'hi Error ' . style_keyword
execute 'hi DiagnosticError ' . style_keyword

execute 'hi Directory ' . style_function
execute 'hi DiagnosticInfo ' . style_function

execute 'hi DiagnosticWarn ' . style_special

execute 'hi DiagnosticHint ' . style_macro

execute 'hi LspSagaDiagnosticBorder ' . style_normal

execute 'hi DiagnosticSignError ' . style_sign_error
execute 'hi DiagnosticSignWarn ' . style_sign_warning
execute 'hi def DiagnosticSignErrorNumber ' . style_sign_errorfg
execute 'hi def DiagnosticSignWarnNumber ' . style_sign_warningfg

execute 'hi def DapSignBreakpoint ' . style_sign_breakpoint
execute 'hi def DapSignStopped ' . style_sign_error
execute 'hi def DapSignBreakpointNumber ' . style_sign_breakpointfg
execute 'hi def DapSignStoppedNumber ' . style_sign_errorfg

sign define DiagnosticSignError text=E texthl=DiagnosticSignError linehl=DiagnosticSignError numhl=DiagnosticSignErrorNumber
sign define DiagnosticSignWarn text=W texthl=DiagnosticSignWarn linehl=DiagnosticSignWarn numhl=DiagnosticSignWarnNumber
sign define DiagnosticSignInfo text=I texthl=DiagnosticSignInfo linehl= numhl=DiagnosticSignInfo
sign define DiagnosticSignHint text=H texthl=DiagnosticSignHint linehl= numhl=DiagnosticSignHint

sign define DapBreakpoint text=B texthl=DapSignBreakpoint linehl=DapSignBreakpoint numhl=DapSignBreakpointNumber
sign define DapStopped text=S texthl=DapSignStopped linehl=DapSignStopped numhl=DapSignStoppedNumber
]])

-- vim.cmd([[hi FloatBorder guibg=NONE]]) -- if you don't want weird border background colors around the popup.

-- local function changeColorScheme()
--     local style_normal = { fg = g.terminal_color_15, ctermfg=15, bg = nil, ctermbg=nil, gui=nil, cterm=nil }
--     local style_function = { fg = nil, ctermfg=12, bg = nil, ctermbg=nil, gui=nil, cterm=nil }
--     local style_identifier = { fg = nil, ctermfg=12, bg = nil, ctermbg=nil, gui=nil, cterm=nil }
--     local style_keyword = { fg = nil, ctermfg=12, bg = nil, ctermbg=nil, gui=nil, cterm=nil }
--     local style_type = { fg = nil, ctermfg=12, bg = nil, ctermbg=nil, gui=nil, cterm=nil }
--     local style_const = { fg = nil, ctermfg=12, bg = nil, ctermbg=nil, gui=nil, cterm=nil }
--     local style_string = { fg = nil, ctermfg=12, bg = nil, ctermbg=nil, gui=nil, cterm=nil }
--     local style_macro = { fg = nil, ctermfg=12, bg = nil, ctermbg=nil, gui=nil, cterm=nil }
--     local style_special = { fg = nil, ctermfg=12, bg = nil, ctermbg=nil, gui=nil, cterm=nil }
--     local style_tag = { fg = nil, ctermfg=12, bg = nil, ctermbg=nil, gui=nil, cterm=nil }
--     local style_comment = { fg = nil, ctermfg=12, bg = nil, ctermbg=nil, gui=nil, cterm=nil }
--     if (g.colors_name == "gruvbox") then
--         local style_special = { fg = nil, ctermfg=12, bg = nil, ctermbg=nil, gui=nil, cterm=nil }
--         local style_tag = { fg = nil, ctermfg=12, bg = nil, ctermbg=nil, gui=nil, cterm=nil }
--         local style_comment = { fg = nil, ctermfg=12, bg = nil, ctermbg=nil, gui=nil, cterm=nil }
--     end
--     vim.api.nvim_set_hl(0, 'Function', style_function)
-- end

-- vim.api.nvim_create_autocmd({ "ColorScheme"}, { callback = changeColorScheme})

-- vim.cmd.colorscheme('gruvbox')
