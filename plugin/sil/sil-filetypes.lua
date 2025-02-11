---@diagnostic disable: undefined-field
local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

local function setft(ftype)
    vim.bo.filetype = ftype
end

-- - ---------------------------------------------------------------------------- -
-- -                              ZDoom lump parsing                              -
-- - ---------------------------------------------------------------------------- -

local zdoomlumps = {}
local runtimepaths = vim.api.nvim_list_runtime_paths()

local function list_dir(dir)
    return vim.split(vim.fn.glob(dir .. "/*"), '\n', { trimempty = true })
end

-- possible use in the future?
for _, path in ipairs(runtimepaths) do
    local files = list_dir(path .. "/syntax/zdoomlumps")
    for _, file in ipairs(files) do
        file = vim.fn.fnamemodify(file, ":t")
        if file ~= "template-file.vim" then
            local name = file:gsub(".vim", "")
            local lname = name:lower()
            local cname = name:upper()
            zdoomlumps[lname .. ".txt"] = "zdoomlump"
            zdoomlumps[cname] = "zdoomlump"
        end
    end
end

-- - ---------------------------------------------------------------------------- -
-- -                                   Shebang                                    -
-- - ---------------------------------------------------------------------------- -

local shebangList = {
    ["node"] = "javascript",
    ["npx"] = "javascript",
    ["bun"] = "javascript",
    ["rdmd"] = "d",
    ["rund"] = "d",
    ["dub"] = "d",
    ["fish"] = "fish",
}

local function setCustomHighlight(lang)
    if vim.g.colors_name ~= 'despair' then return end

    vim.cmd([[syn match   dCustomFunc     "\zs\(\k\w*\)*\s*\ze("]])

    if lang == "d" then
        vim.cmd([[syn match   dCustomDFunc     "\zs\(\k\w*\)*\ze\!"]])
    end
end

local function detectShebangPattern()
    for k, v in pairs(shebangList) do
        local sb = vim.api.nvim_buf_get_lines(0, 0, -1, false)[1]
        if sb == nil then return end
        if sb:find("^#!/bin/" .. k) ~= nil or
           sb:find("^#!/usr/bin/" .. k) ~= nil or
           sb:find("^#!/bin/env " .. k) ~= nil or
           sb:find("^#!/bin/env %-S " .. k) ~= nil or
           sb:find("^#!/usr/bin/env " .. k) ~= nil or
           sb:find("^#!/usr/bin/env %-S " .. k) ~= nil then
              setft(v)
              if vim.g.colors_name ~= 'despair' then setCustomHighlight(v) end
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

do -- start autocmd block
    -- - ---------------------------------------------------------------------------- -
    -- -                                   Autocmd                                    -
    -- - ---------------------------------------------------------------------------- -

    -- - -------------------------------- Languages --------------------------------- -
    local c = {"*.c", "*.h"}
    local cpp = {"*.cpp", "*.hpp"}
    local cs = {"*.cs"}
    local c3 = {"*.c3"}
    local d = {"*.d"}
    local dart = {"*.dart"}
    local haxe = {"*.hx"}
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
    local fusion = {"*.fu"} -- possible future generics

    local bang_generics = {d}
    local angle_generics = {cpp, cs, dart, haxe, java, jspp, kotlin, rust, swift, ts, fusion}
    local square_generics = {go}
    local no_generics = {c, c3, js, lua, py, sdl}

    local event_filetype = { "BufEnter", "BufNew" }

    augroup("SetCustomFiletypes", { clear = true })

    -- - -------------------------------- Templates --------------------------------- -
    -- D templates, template!val and template!(val)
    autocmd(event_filetype, { group = "SetCustomFiletypes", pattern = concat(bang_generics), callback = function() setCustomHighlight("d") end })
    -- C++ templates, template<val>, no need for custom
    autocmd(event_filetype, { group = "SetCustomFiletypes", pattern = concat(angle_generics), callback = function() setCustomHighlight("") end })
    -- go templates, template[val], no need for custom
    autocmd(event_filetype, { group = "SetCustomFiletypes", pattern = concat(square_generics), callback = function() setCustomHighlight("") end })
    -- No templates
    autocmd(event_filetype, { group = "SetCustomFiletypes", pattern = concat(no_generics), callback = function() setCustomHighlight("") end })

    -- Shebang
    autocmd(event_filetype, { group = "SetCustomFiletypes", pattern = {"*"}, callback = detectShebangPattern })
end -- end autocmd block



