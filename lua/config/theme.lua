-- for D: https://github.com/SirSireesh/vim-dlang-phobos-highlighter/blob/master/after/syntax/d.vim
-- ditto: https://github.com/neovim/neovim/blob/master/runtime/syntax/d.vim

local g = vim.g -- global variables

-------------------- Functions --------------------------------------

-- https://neovim.io/doc/user/api.html#nvim_set_hl()
-- Parameters:
--     {name} Highlight group name, e.g. "ErrorMsg"
--     {val} Highlight definition map, accepts the following keys:
-- fg (or foreground): color name or "#RRGGBB", see note.
-- bg (or background): color name or "#RRGGBB", see note.
-- sp (or special): color name or "#RRGGBB"
-- blend: integer between 0 and 100
-- bold: boolean
-- standout: boolean
-- underline: boolean
-- undercurl: boolean
-- underdouble: boolean
-- underdotted: boolean
-- underdashed: boolean
-- strikethrough: boolean
-- italic: boolean
-- reverse: boolean
-- nocombine: boolean
-- link: name of another highlight group to link to, see :hi-link.
-- default: Don't override existing definition :hi-default
-- ctermfg: Sets foreground of cterm color ctermfg
-- ctermbg: Sets background of cterm color ctermbg
-- cterm: cterm attribute map, like highlight-args.
-- force: if true force update the highlight group when it exists.
local function highlight(name, val)
    vim.api.nvim_set_hl(0, name, val)
end

-- see hi
local function highlightAll(names, val)
    for i = 1, #names do
        highlight(names[i], val)
    end
end

-------------------- Highlight --------------------------------------
highlight("QuickFixLine", {bg = "#3c3836", ctermfg = 8})

-- Custom function highlight
highlightAll({"dCustomFunc", "dCustomDFunc"}, {link = "Function"})

-- Borders
highlightAll({
    "LspSagaCodeActionBorder",
    "LspSagaLspFinderBorder",
    "FinderSpinnerBorder",
    "DefinitionBorder",
    "LspSagaHoverBorder",
    "LspSagaRenameBorder",
    "LspSagaSignatureHelpBorder",
    "LSOutlinePreviewBorder",
    "LspSagaGroupName",
    "LspSagaDiagnosticError",
    "FzfLuaBorder"
}, {link = "LspSagaDiagnosticBorder"})

-- vim.illuminate

local illuminated_col = {bg = "#3c3836", ctermbg = 8}
local illuminated_nil = {}

highlightAll({"IlluminatedWordText"}, illuminated_nil)
highlightAll({"IlluminatedWordRead", "IlluminatedWordWrite"}, illuminated_col)

highlight("SpectreHeader", {link = "Comment"})
highlight("SpectreBody", {link = "Normal"})
highlight("SpectreFile", {link = "Macro"})
highlight("SpectreDir", {link = "Comment"})
highlight("SpectreSearch", {link = "DiffChange"})
-- highlight("SpectreSearch", {ctermfg = 1, fg = g.terminal_color_1, italic = true})
highlight("SpectreBorder", {link = "Comment"})
highlight("SpectreReplace", {link = "DiffDelete"})
-- highlight("SpectreReplace", {ctermfg = 10, fg = g.terminal_color_10})

highlight("ExtraWhitespace", {bg = "#502828", ctermbg = 1})

-- hydra

highlight("HydraRed",      {fg = g.terminal_color_1, ctermfg = 1})
highlight("HydraBlue",     {fg = g.terminal_color_12, ctermfg = 12})
highlight("HydraAmaranth", {fg = g.terminal_color_5, ctermfg = 5})
highlight("HydraTeal",     {fg = g.terminal_color_14, ctermfg = 14})
highlight("HydraPink",     {fg = g.terminal_color_13, ctermfg = 13})

-- custom gruv colors

if g.colors_name == 'gruvbox' then
    local style_normal      = {fg = g.terminal_color_15, ctermfg = 15}
    local style_function    = {fg = g.terminal_color_12, ctermfg = 12}
    local style_keyword     = {fg = g.terminal_color_9, ctermfg = 9}
    local style_type        = {fg = g.terminal_color_9, ctermfg = 9, italic = true}
    local style_const       = {fg = g.terminal_color_13, ctermfg = 13}
    local style_string      = {fg = g.terminal_color_10, ctermfg = 10}
    local style_macro       = {fg = g.terminal_color_14, ctermfg = 14}
    local style_identifier  = {fg = "#d5c4a1", ctermfg = 15}
    local style_special     = {fg = "#fe8019", ctermfg = 11}
    local style_tag         = {fg = "#7c6f63", ctermfg = 7}
    local style_comment     = {fg = "#7c6f63", ctermfg = 7, italic = true}

    local style_sign_warning    = {bg = "#352C28", ctermbg = 11}
    local style_sign_error      = {bg = "#302828", ctermbg = 1}
    local style_sign_warning_fg = {fg = "#fe8019", bg = "#352C28", ctermfg = 11, ctermbg = 3}
    local style_sign_error_fg   = {fg = "#fb4934", bg = "#302828", ctermfg = 9, ctermbg = 1}
    local style_breakpoint      = {bg = "#282830", ctermbg = 4}
    local style_breakpoint_fg   = {fg = "#83a598", bg = "#283030", ctermfg = 12, ctermbg = 4}

    -- common syntax

    highlightAll({"Normal", "NormalFloat", "FloatBorder"}, style_normal)
    highlightAll({"Function"}, style_function)
    highlightAll({"Identifier", "Delimiter"}, style_identifier)
    highlightAll({"Label", "Conditional", "Debug", "Exception", "Include", "Repeat"}, style_keyword)
    highlightAll({"StorageClass", "Structure", "Typedef", "Keyword", "Operator", "Statement"}, style_keyword)
    highlightAll({"Type"}, style_type)
    highlightAll({"Constant", "Boolean", "Number", "Float"}, style_const)
    highlightAll({"String", "Character"}, style_string)
    highlightAll({"Special", "SpecialChar"}, style_special)
    highlightAll({"Macro", "PreProc", "Define", "Precondit"}, style_macro)
    highlightAll({"Todo", "Tag"}, style_tag)
    highlightAll({"Comment"}, style_comment)

    highlightAll({"Search"}, {reverse = true})

    -- https://github.com/kevinhwang91/nvim-ufo#highlight-groups
    local style_fold_line = {bg = "#353535", ctermbg = 8}
    highlight("UfoFoldedBg", style_fold_line)

    highlight("vimTodoListsDone", style_comment)
    highlight("vimTodoListsNormal", style_normal)
    highlight("vimTodoListsImportant", style_macro)

    -- PQF && DAP

    highlightAll({"LspSagaDiagnosticBorder"}, style_normal)

    highlightAll({"Error", "DiagnosticError"}, style_keyword)
    highlightAll({"Directory", "DiagnosticInfo"}, style_function)
    highlightAll({"DiagnosticWarn"}, style_special)
    highlightAll({"DiagnosticHint"}, style_macro)

    highlightAll({"DiagnosticSignError", "DapSignStopped"}, style_sign_error)
    highlightAll({"DiagnosticSignWarn"}, style_sign_warning)
    highlightAll({"DiagnosticSignErrorNumber", "DapSignStoppedNumber"}, style_sign_error_fg)
    highlightAll({"DiagnosticSignWarnNumber"}, style_sign_warning_fg)

    highlightAll({"DapSignBreakpoint"}, style_breakpoint)
    highlightAll({"DapSignBreakpointNumber"}, style_breakpoint_fg)

    -- CMP

    highlightAll({"CmpItemKindText", "CmpItemKindField", "CmpItemKindValue", "CmpItemKindOperator", "CmpItemKindTypeParameter"}, style_normal)
    highlightAll({"CmpItemKindSnippet", "CmpItemKindKeyword", "CmpItemKindUnit", "CmpItemKindEnum"}, style_keyword)
    highlightAll({"CmpItemAbbrDeprecated"}, style_comment)
    highlightAll({"CmpItemAbbrMatch", "CmpItemAbbrMatchFuzzy"}, style_identifier)
    highlightAll({"CmpItemKindValue", "CmpItemKindEnumMember", "CmpItemKindColor", "CmpItemKindConstant", "CmpItemKindEvent"}, style_const)
    highlightAll({"CmpItemKindFile", "CmpItemKindReference", "CmpItemKindFolder"}, style_string)
    highlightAll({"CmpItemKindMethod", "CmpItemKindFunction", "CmpItemKindConstructor", "CmpItemKindProperty"}, style_function)
    highlightAll({"CmpItemKindClass", "CmpItemKindStruct", "CmpItemKindInterface", "CmpItemKindModule"}, style_special)

    vim.cmd([[
        sign define DiagnosticSignError text=E texthl=DiagnosticSignError linehl=DiagnosticSignError numhl=DiagnosticSignErrorNumber
        sign define DiagnosticSignWarn text=W texthl=DiagnosticSignWarn linehl=DiagnosticSignWarn numhl=DiagnosticSignWarnNumber
        sign define DiagnosticSignInfo text=I texthl=DiagnosticSignInfo linehl= numhl=DiagnosticSignInfo
        sign define DiagnosticSignHint text=H texthl=DiagnosticSignHint linehl= numhl=DiagnosticSignHint

        sign define DapBreakpoint text=B texthl=DapSignBreakpoint linehl=DapSignBreakpoint numhl=DapSignBreakpointNumber
        sign define DapStopped text=S texthl=DapSignStopped linehl=DapSignStopped numhl=DapSignStoppedNumber

        hi! link @constant.builtin.d Constant
        hi! link @lsp.type.macro.c Constant
    ]])
end



