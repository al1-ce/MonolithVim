local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

local function setft(ftype)
    vim.bo.filetype = ftype
end

local shebangList = {
    ["node"] = "javascript",
    ["npx"] = "javascript",
    ["rdmd"] = "d",
    ["rund"] = "d",
    ["dub"] = "d",
    ["fish"] = "fish",
}

local function setCustomHighlight(lang)
    vim.cmd([[syn match   dCustomFunc     "\zs\(\k\w*\)*\s*\ze("]])

    if lang == "d" then
        vim.cmd([[syn match   dCustomDFunc     "\zs\(\k\w*\)*\ze\!"]])
    end
end

local function detectShebangPattern()
    for k, v in pairs(shebangList) do
        local sb = vim.api.nvim_buf_get_lines(0, 0, -1, false)[1]
        if sb:find("^#!/bin/" .. k) ~= nil or
           sb:find("^#!/usr/bin/" .. k) ~= nil or
           sb:find("^#!/bin/env " .. k) ~= nil or
           sb:find("^#!/bin/env %-S " .. k) ~= nil or
           sb:find("^#!/usr/bin/env " .. k) ~= nil or
           sb:find("^#!/usr/bin/env %-S " .. k) ~= nil then
            setft(v)
            setCustomHighlight(v)
        end
    end
end

local function concat(arrays)
    local nt = {}
    for _,a in ipairs(arrays) do
        for _,v in ipairs(a) do
            table.insert(nt, v)
        end
    end
    return nt
end

-------------------- Autocmd --------------------------------------
do -- start autocmd block
    -- Languages
    local c = {"*.c", "*.h"}
    local cpp = {"*.cpp", "*.hpp"}
    local cs = {"*.cs"}
    local c3 = {"*.c3"}
    local d = {"*.d"}
    local dart = {"*.dart"}
    local haxe = {"*.jx"}
    local go = {"*.go"}
    local java = {"*.java", "*.class"}
    local js = {"*.js"}
    local jspp = {"*.jspp", "*.jsp"}
    local kotlin = {"*.kt","*.kts","*.ktm"}
    local lua = {"*.lua"}
    local py = {"*.py"}
    local rust = {"*.rs"}
    local sdl = {"*.sdl"}
    local swift = {"*.swift"}
    local ts = {"*.ts"}

    local event_filetype = { "BufEnter", "BufRead", "BufNewFile" }

    augroup("SetCustomFiletypes", { clear = true })
    augroup("ToggleCursorLine", { clear = true })

    -- Templates
    -- D templates, template!val and template!(val)
    autocmd(event_filetype, { group = "SetCustomFiletypes", pattern = concat({d}), callback = function() setCustomHighlight("d") end })
    -- C++ templates, template<val>, no need for custom
    autocmd(event_filetype, { group = "SetCustomFiletypes", pattern = concat({cpp, cs, dart, haxe, java, jspp, kotlin, rust, swift, ts}), callback = function() setCustomHighlight("") end })
    -- go templates, template[val], no need for custom
    autocmd(event_filetype, { group = "SetCustomFiletypes", pattern = concat({go}), callback = function() setCustomHighlight("") end })
    -- No templates
    autocmd(event_filetype, { group = "SetCustomFiletypes", pattern = concat({c, c3, js, lua, py, sdl}), callback = function() setCustomHighlight("") end })

    -- Shebang
    autocmd(event_filetype, { group = "SetCustomFiletypes", pattern = {"*"}, callback = detectShebangPattern })

    autocmd({"WinEnter", "BufEnter"}, { group = "ToggleCursorLine", pattern = "*", command = "setlocal cursorline" })
    autocmd({"WinLeave", "BufLeave"}, { group = "ToggleCursorLine", pattern = "*", command = "setlocal nocursorline" })

    -- Set filetypes
    autocmd(event_filetype, { group = "SetCustomFiletypes", pattern = {"*.sdl"}, callback = function() setft("sdlang") end })
    autocmd(event_filetype, { group = "SetCustomFiletypes", pattern = {"*.bf"}, callback = function() setft("brainfuck") end })
    autocmd(event_filetype, { group = "SetCustomFiletypes", pattern = {"*.jpp", "*.jspp"}, callback = function() setft("jspp") end })
    autocmd(event_filetype, { group = "SetCustomFiletypes", pattern = {"*.fasm"}, callback = function() setft("fasm") end })
    autocmd(event_filetype, { group = "SetCustomFiletypes", pattern = {"*.c3"}, callback = function() setft("c3") end })
    autocmd(event_filetype, { group = "SetCustomFiletypes", pattern = {"*.vs", "*.fs"}, callback = function() setft("glsl") end })

    -- ;h - to edit c headers and source files faster
    -- use :Ouroboros instead
    -- vim.cmd([[au BufEnter,BufNew *.c nnoremap <silent> ;h :e %<.h<CR>]])
    -- vim.cmd([[au BufEnter,BufNew *.h nnoremap <silent> ;h :e %<.c<CR>]])
    -- vim.cmd([[au BufEnter,BufNew *.hpp nnoremap <silent> ;h :e %<.cpp<CR>]])
    -- vim.cmd([[au BufEnter,BufNew *.cpp nnoremap <silent> ;h :e %<.hpp<CR>]])
end -- end autocmd block


