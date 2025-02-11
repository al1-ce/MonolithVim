-- for D: https://github.com/SirSireesh/vim-dlang-phobos-highlighter/blob/master/after/syntax/d.vim
-- ditto: https://github.com/neovim/neovim/blob/master/runtime/syntax/d.vim

local g = vim.g -- global variables

---@diagnostic disable-next-line: unused-local
local color_indices = {
    c0  = "#000000",
    c1  = "#880000",
    c2  = "#008800",
    c3  = "#aa8800",
    c4  = "#000088",
    c5  = "#aa0088",
    c6  = "#00aa88",
    c7  = "#888888",
    c8  = "#555555",
    c9  = "#ff0000",
    c10 = "#00ff00",
    c11 = "#ffff00",
    c12 = "#0000ff",
    c13 = "#ff00ff",
    c14 = "#00ffff",
    c15 = "#ffffff",
}

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

local function colorscheme_set()
    -------------------- Highlight --------------------------------------
    -- Custom function highlight
    highlightAll({"dCustomFunc", "dCustomDFunc"}, {link = "Function"})
    highlight("haxeFunction", { link = "Keyword" })

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

    highlight("SpectreHeader", {link = "Comment"})
    highlight("SpectreBody", {link = "Normal"})
    highlight("SpectreFile", {link = "Macro"})
    highlight("SpectreDir", {link = "Comment"})
    highlight("SpectreSearch", {link = "DiffChange"})
    -- highlight("SpectreSearch", {ctermfg = 1, fg = g.terminal_color_1, italic = true})
    highlight("SpectreBorder", {link = "Comment"})
    highlight("SpectreReplace", {link = "DiffDelete"})
    -- highlight("SpectreReplace", {ctermfg = 10, fg = g.terminal_color_10})


    highlightAll({"Search"}, {reverse = true})
    highlightAll({"Cursor"}, {reverse = true})
    -- custom gruv colors

    local custom_colors = {
        dk_gray = g.terminal_color_8,
        gray = g.terminal_color_15,
        lt_gray = g.terminal_color_15,
        orange = g.terminal_color_11,
        fn_orange = g.terminal_color_3,
        fn_red = g.terminal_color_1,
        fn_blue = g.terminal_color_4,
        fn_cyan = g.terminal_color_6,
        fn_gray = g.terminal_color_8
    }

    ---@diagnostic disable-next-line: undefined-field
    if g.colors_name == 'gruvbox' and vim.opt.termguicolors._value == true then
        custom_colors.dk_gray = "#7c6f63"
        custom_colors.gray = "#bdae95"
        custom_colors.lt_gray = "#d5c4a1"
        custom_colors.orange = "#fe8019"
        custom_colors.fn_orange = "#352C28"
        custom_colors.fn_red = "#302828"
        custom_colors.fn_blue = "#282830"
        custom_colors.fn_cyan = "#283030"
        custom_colors.fn_gray = "#353535"

        local style_normal      = {fg = g.terminal_color_15, ctermfg = 15}
        local style_delimiter   = {fg = custom_colors.gray, ctermfg = 15}
        local style_function    = {fg = g.terminal_color_12, ctermfg = 12}
        local style_keyword     = {fg = g.terminal_color_9, ctermfg = 9}
        local style_type        = {fg = g.terminal_color_9, ctermfg = 9, italic = true}
        local style_const       = {fg = g.terminal_color_13, ctermfg = 13}
        local style_string      = {fg = g.terminal_color_10, ctermfg = 10}
        local style_macro       = {fg = g.terminal_color_14, ctermfg = 14}
        local style_identifier  = {fg = custom_colors.lt_gray, ctermfg = 15}
        local style_special     = {fg = custom_colors.orange, ctermfg = 11}
        local style_tag         = {fg = custom_colors.dk_gray, ctermfg = 7}
        local style_comment     = {fg = custom_colors.dk_gray, ctermfg = 7, italic = true}

        -- local style_cmp_comment     = {fg = custom_colors.dk_gray, ctermfg = 7, italic = true}
        local style_cmp_normal      = {fg = g.terminal_color_15, ctermfg = 15}
        local style_cmp_const       = {fg = g.terminal_color_13, ctermfg = 13}
        local style_cmp_keyword     = {fg = g.terminal_color_9, ctermfg = 9}
        local style_cmp_string      = {fg = g.terminal_color_10, ctermfg = 10}
        local style_cmp_function    = {fg = g.terminal_color_12, ctermfg = 12}
        local style_cmp_special     = {fg = custom_colors.orange, ctermfg = 11}

        local style_underline_error   = { sp = g.terminal_color_9, underline = true }
        local style_underline_hint    = { sp = g.terminal_color_12, underline = true }
        local style_underline_info    = { sp = g.terminal_color_13, underline = true }
        local style_underline_ok      = { sp = g.terminal_color_10, underline = true }
        local style_underline_warning = { sp = custom_colors.orange, underline = true }

        local style_sign_warning    = {bg = custom_colors.fn_orange, ctermbg = 11}
        local style_sign_error      = {bg = custom_colors.fn_red, ctermbg = 1}
        local style_sign_warning_fg = {fg = custom_colors.orange, bg = custom_colors.fn_orange, ctermfg = 11, ctermbg = 3}
        local style_sign_error_fg   = {fg = g.terminal_color_9, bg = custom_colors.fn_red, ctermfg = 9, ctermbg = 1}
        local style_breakpoint      = {bg = custom_colors.fn_blue, ctermbg = 4}
        local style_breakpoint_fg   = {fg = g.terminal_color_12, bg = custom_colors.fn_cyan, ctermfg = 12, ctermbg = 4}

        -- https://github.com/kevinhwang91/nvim-ufo#highlight-groups
        local style_fold_line = {bg = custom_colors.fn_gray, ctermbg = 8}

        -- common syntax

        --  DiagnosticUnderlineWarnxxx cterm=underline gui=underline guisp=NvimLightYellow
        highlightAll({"Normal", "NormalFloat", "FloatBorder", "cParenError", "MatchParen", "@variable", "@module.d"}, style_normal)
        highlightAll({"Function"}, style_function)
        highlightAll({"Delimiter", "@punctuation.delimiter.d"}, style_delimiter)
        -- highlightAll({"@punctuation.bracket.d"}, style_special)
        highlightAll({"Identifier"}, style_identifier)
        highlightAll({"Label", "Conditional", "Debug", "Exception", "Include", "Repeat"}, style_keyword)
        highlightAll({"StorageClass", "Structure", "Typedef", "Keyword", "Operator", "Statement"}, style_keyword)
        highlightAll({"Type", "@type.builtin.d"}, style_type)
        highlightAll({"Constant", "Boolean", "Number", "Float"}, style_const)
        highlightAll({"String", "Character"}, style_string)
        highlightAll({"Special", "SpecialChar"}, style_special)
        highlightAll({"Macro", "PreProc", "Define", "Precondit"}, style_macro)
        highlightAll({"Todo", "Tag"}, style_tag)
        highlightAll({"Comment", "WinSeparator"}, style_comment)

        highlight("DiagnosticUnderlineError", style_underline_error)
        highlight("DiagnosticUnderlineHint", style_underline_hint)
        highlight("DiagnosticUnderlineInfo", style_underline_info)
        highlight("DiagnosticUnderlineOk", style_underline_ok)
        highlight("DiagnosticUnderlineWarn", style_underline_warning)

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

        highlight("LuaLineDiffAdd", style_string)
        highlight("LuaLineDiffChange", style_special)
        highlight("LuaLineDiffDelete", style_keyword)

        highlight("LeapBackdrop", style_comment)

        -- CMP

        -- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-get-types-on-the-left-and-offset-the-menu
        highlightAll({"CmpItemAbbrDeprecated"}, style_comment)
        highlightAll({"CmpItemAbbrMatch", "CmpItemAbbrMatchFuzzy", "PmenuSel"}, style_identifier)
        highlightAll({"CmpItemMenu"}, style_comment)
        highlightAll({"CmpItemKindText", "CmpItemKindField", "CmpItemKindValue", "CmpItemKindOperator", "CmpItemKindTypeParameter"}, style_cmp_normal)
        highlightAll({"CmpItemKindSnippet", "CmpItemKindKeyword", "CmpItemKindUnit", "CmpItemKindEnum"}, style_cmp_keyword)
        highlightAll({"CmpItemKindValue", "CmpItemKindEnumMember", "CmpItemKindColor", "CmpItemKindConstant", "CmpItemKindEvent"}, style_cmp_const)
        highlightAll({"CmpItemKindFile", "CmpItemKindReference", "CmpItemKindFolder"}, style_cmp_string)
        highlightAll({"CmpItemKindMethod", "CmpItemKindFunction", "CmpItemKindConstructor", "CmpItemKindProperty"}, style_cmp_function)
        highlightAll({"CmpItemKindClass", "CmpItemKindStruct", "CmpItemKindInterface", "CmpItemKindModule"}, style_cmp_special)

        highlight("QuickFixLine", {bg = "#3c3836", ctermfg = 8})

        -- vim.illuminate

        local illuminated_col = {bg = "#3c3836", ctermbg = 8}
        local illuminated_nil = {}

        highlightAll({"IlluminatedWordText"}, illuminated_nil)
        highlightAll({"IlluminatedWordRead", "IlluminatedWordWrite"}, illuminated_col)
        highlight("ExtraWhitespace", {bg = "#502828", ctermbg = 1})
    end

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

colorscheme_set()

vim.api.nvim_create_user_command("PlugColorschemeSet", colorscheme_set, {})

