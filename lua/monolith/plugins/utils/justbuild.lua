
local ____modules = {}
local ____moduleCache = {}
local ____originalRequire = require
local function require(file, ...)
    if ____moduleCache[file] then
        return ____moduleCache[file].value
    end
    if ____modules[file] then
        local module = ____modules[file]
        ____moduleCache[file] = { value = (select("#", ...) > 0) and module(...) or module(file) }
        return ____moduleCache[file].value
    else
        if ____originalRequire then
            return ____originalRequire(file)
        else
            error("module '" .. file .. "' not found")
        end
    end
end
____modules = {
["justbuild"] = function(...) 
-- Lua Library inline imports
local __TS__StringSplit
do
    local sub = string.sub
    local find = string.find
    function __TS__StringSplit(source, separator, limit)
        if limit == nil then
            limit = 4294967295
        end
        if limit == 0 then
            return {}
        end
        local result = {}
        local resultIndex = 1
        if separator == nil or separator == "" then
            for i = 1, #source do
                result[resultIndex] = sub(source, i, i)
                resultIndex = resultIndex + 1
            end
        else
            local currentPos = 1
            while resultIndex <= limit do
                local startPos, endPos = find(source, separator, currentPos, true)
                if not startPos then
                    break
                end
                result[resultIndex] = sub(source, currentPos, startPos - 1)
                resultIndex = resultIndex + 1
                currentPos = endPos + 1
            end
            if resultIndex <= limit then
                result[resultIndex] = sub(source, currentPos)
            end
        end
        return result
    end
end

local function __TS__ArrayFilter(self, callbackfn, thisArg)
    local result = {}
    local len = 0
    for i = 1, #self do
        if callbackfn(thisArg, self[i], i - 1, self) then
            len = len + 1
            result[len] = self[i]
        end
    end
    return result
end

local function __TS__CountVarargs(...)
    return select("#", ...)
end

local function __TS__ArraySplice(self, ...)
    local args = {...}
    local len = #self
    local actualArgumentCount = __TS__CountVarargs(...)
    local start = args[1]
    local deleteCount = args[2]
    if start < 0 then
        start = len + start
        if start < 0 then
            start = 0
        end
    elseif start > len then
        start = len
    end
    local itemCount = actualArgumentCount - 2
    if itemCount < 0 then
        itemCount = 0
    end
    local actualDeleteCount
    if actualArgumentCount == 0 then
        actualDeleteCount = 0
    elseif actualArgumentCount == 1 then
        actualDeleteCount = len - start
    else
        actualDeleteCount = deleteCount or 0
        if actualDeleteCount < 0 then
            actualDeleteCount = 0
        end
        if actualDeleteCount > len - start then
            actualDeleteCount = len - start
        end
    end
    local out = {}
    for k = 1, actualDeleteCount do
        local from = start + k
        if self[from] ~= nil then
            out[k] = self[from]
        end
    end
    if itemCount < actualDeleteCount then
        for k = start + 1, len - actualDeleteCount do
            local from = k + actualDeleteCount
            local to = k + itemCount
            if self[from] then
                self[to] = self[from]
            else
                self[to] = nil
            end
        end
        for k = len - actualDeleteCount + itemCount + 1, len do
            self[k] = nil
        end
    elseif itemCount > actualDeleteCount then
        for k = len - actualDeleteCount, start + 1, -1 do
            local from = k + actualDeleteCount
            local to = k + itemCount
            if self[from] then
                self[to] = self[from]
            else
                self[to] = nil
            end
        end
    end
    local j = start + 1
    for i = 3, actualArgumentCount do
        self[j] = args[i]
        j = j + 1
    end
    for k = #self, len - actualDeleteCount + itemCount + 1, -1 do
        self[k] = nil
    end
    return out
end

local function __TS__ArrayIsArray(value)
    return type(value) == "table" and (value[1] ~= nil or next(value) == nil)
end

local function __TS__ArrayConcat(self, ...)
    local items = {...}
    local result = {}
    local len = 0
    for i = 1, #self do
        len = len + 1
        result[len] = self[i]
    end
    for i = 1, #items do
        local item = items[i]
        if __TS__ArrayIsArray(item) then
            for j = 1, #item do
                len = len + 1
                result[len] = item[j]
            end
        else
            len = len + 1
            result[len] = item
        end
    end
    return result
end

local function __TS__ArrayIncludes(self, searchElement, fromIndex)
    if fromIndex == nil then
        fromIndex = 0
    end
    local len = #self
    local k = fromIndex
    if fromIndex < 0 then
        k = len + fromIndex
    end
    if k < 0 then
        k = 0
    end
    for i = k + 1, len do
        if self[i] == searchElement then
            return true
        end
    end
    return false
end

local function __TS__StringStartsWith(self, searchString, position)
    if position == nil or position < 0 then
        position = 0
    end
    return string.sub(self, position + 1, #searchString + position) == searchString
end
-- End of Lua Library inline imports
local ____exports = {}
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local themes = require("telescope.themes")
local async = require("plenary.job")
local notify = require("notify")
local function popup(message, errlvl, title)
    if errlvl == nil then
        errlvl = "info"
    end
    if title == nil then
        title = "Info"
    end
    notify(message, errlvl, {title = title})
end
local function getConfigDir()
    return vim.fn.fnamemodify(
        vim.fn.expand("$MYVIMRC"),
        ":p:h"
    )
end
local just = ("just -f " .. getConfigDir()) .. "/justfile"
local function get_build_names(lang)
    if lang == nil then
        lang = ""
    end
    local outlist = vim.fn.system(just .. " --list")
    local arr = __TS__StringSplit(outlist, "\n")
    table.remove(arr, 1)
    table.remove(arr)
    local pjustfile = vim.fn.getcwd() .. "/justfile"
    if vim.fn.filereadable(pjustfile) == 1 and pjustfile ~= getConfigDir() .. "/justfile" then
        local overrideList = vim.fn.system(("just -f " .. pjustfile) .. " --list")
        local oarr = __TS__StringSplit(overrideList, "\n")
        table.remove(oarr, 1)
        table.remove(oarr)
        local rem = false
        do
            local i = 0
            while i < #arr do
                do
                    local j = 0
                    while j < #oarr do
                        local fnor = __TS__ArrayFilter(
                            __TS__StringSplit(arr[i + 1], " "),
                            function(____, e) return e ~= "" end
                        )[1]
                        local fnov = __TS__ArrayFilter(
                            __TS__StringSplit(oarr[j + 1], " "),
                            function(____, e) return e ~= "" end
                        )[1]
                        if fnor == fnov then
                            rem = true
                        end
                        j = j + 1
                    end
                end
                if rem then
                    __TS__ArraySplice(arr, i, 1)
                end
                rem = false
                i = i + 1
            end
        end
        arr = __TS__ArrayConcat(arr, oarr)
    end
    local tbl = {}
    do
        local i = 0
        while i < #arr do
            local comment = __TS__StringSplit(arr[i + 1], "#")[2]
            local options = __TS__StringSplit(
                __TS__StringSplit(arr[i + 1], "#")[1],
                " "
            )
            options = __TS__ArrayFilter(
                options,
                function(____, e) return e ~= "" end
            )
            local name = options[1]
            local langname = string.lower(__TS__StringSplit(name, "_")[1])
            if langname == string.lower(lang) or lang == "" or langname == "any" then
                local parts = __TS__StringSplit(name, "_")
                local out
                if #parts == 1 then
                    out = parts[1]
                else
                    out = parts[1] .. ": "
                    table.remove(parts, 1)
                    out = out .. table.concat(parts, " ")
                end
                local wd = 34
                local rn = math.max(0, wd - #out)
                out = out .. (string.rep(
                    " ",
                    math.floor(rn)
                ) .. " ") .. (comment == nil and "" or comment)
                tbl[#tbl + 1] = {out, name}
            end
            i = i + 1
        end
    end
    return tbl
end
---
-- @summary Checks if argument is defined as keyword (i.e "FILEPATH", "FILEEXT") and 
-- returns corresponding string. If argument is not keyword function returns single space
-- @param arg Argument to check
local function check_keyword_arg(arg)
    repeat
        local ____switch18 = arg
        local ____cond18 = ____switch18 == "FILEPATH"
        if ____cond18 then
            return vim.fn.expand("%:p")
        end
        ____cond18 = ____cond18 or ____switch18 == "FILENAME"
        if ____cond18 then
            return vim.fn.expand("%:t")
        end
        ____cond18 = ____cond18 or ____switch18 == "FILEDIR"
        if ____cond18 then
            return vim.fn.expand("%:p:h")
        end
        ____cond18 = ____cond18 or ____switch18 == "FILEEXT"
        if ____cond18 then
            return vim.fn.expand("%:e")
        end
        ____cond18 = ____cond18 or ____switch18 == "FILENOEXT"
        if ____cond18 then
            return vim.fn.expand("%:t:r")
        end
        ____cond18 = ____cond18 or ____switch18 == "CWD"
        if ____cond18 then
            return vim.fn.getcwd()
        end
        ____cond18 = ____cond18 or ____switch18 == "RELPATH"
        if ____cond18 then
            return vim.fn.expand("%")
        end
        ____cond18 = ____cond18 or ____switch18 == "RELDIR"
        if ____cond18 then
            return vim.fn.expand("%:h")
        end
        ____cond18 = ____cond18 or ____switch18 == "TIME"
        if ____cond18 then
            return os.date("%H:%M:%S")
        end
        ____cond18 = ____cond18 or ____switch18 == "DATE"
        if ____cond18 then
            return os.date("%d/%m/%Y")
        end
        ____cond18 = ____cond18 or ____switch18 == "USDATE"
        if ____cond18 then
            return os.date("%m/%d/%Y")
        end
        ____cond18 = ____cond18 or ____switch18 == "USERNAME"
        if ____cond18 then
            return os.getenv("USER")
        end
        ____cond18 = ____cond18 or ____switch18 == "PCNAME"
        if ____cond18 then
            return __TS__StringSplit(
                vim.fn.system("uname -a"),
                " "
            )[2]
        end
        ____cond18 = ____cond18 or ____switch18 == "OS"
        if ____cond18 then
            return __TS__StringSplit(
                vim.fn.system("uname"),
                "\n"
            )[1]
        end
        do
            return " "
        end
    until true
end
local function get_build_args(build_name)
    local justloc = just
    local pjustfile = vim.fn.getcwd() .. "/justfile"
    if vim.fn.filereadable(pjustfile) == 1 then
        local bd = __TS__StringSplit(
            vim.fn.system(("just -f " .. pjustfile) .. " --summary"),
            "\n"
        )[1]
        if __TS__ArrayIncludes(
            __TS__StringSplit(bd, " "),
            build_name
        ) then
            justloc = "just -f " .. pjustfile
        end
    end
    local outshow = vim.fn.system((justloc .. " -s ") .. build_name)
    if __TS__StringStartsWith(outshow, "#") then
        outshow = __TS__StringSplit(outshow, "\n")[2]
    end
    local outinfo = __TS__StringSplit(outshow, ":")[1]
    local args = __TS__StringSplit(outinfo, " ")
    table.remove(args, 1)
    if #args == 0 then
        return {}
    end
    local argsout = {}
    do
        local i = 0
        while i < #args do
            local arg = args[i + 1]
            local keywd = check_keyword_arg(arg)
            if keywd == " " then
                local a = vim.fn.input(arg .. ": ", "")
                argsout[#argsout + 1] = ("\"" .. a) .. "\""
            else
                if keywd == "" then
                    keywd = " "
                end
                argsout[#argsout + 1] = ("\"" .. keywd) .. "\""
            end
            i = i + 1
        end
    end
    return argsout
end
local function build_runner(build_name)
    local args = get_build_args(build_name)
    local justloc = just
    local pjustfile = vim.fn.getcwd() .. "/justfile"
    if vim.fn.filereadable(pjustfile) == 1 then
        local bd = __TS__StringSplit(
            vim.fn.system(("just -f " .. pjustfile) .. " --summary"),
            "\n"
        )[1]
        if __TS__ArrayIncludes(
            __TS__StringSplit(bd, " "),
            build_name
        ) then
            justloc = "just -f " .. pjustfile
        end
    end
    local command = (((justloc .. " -d . ") .. build_name) .. " ") .. table.concat(args, " ")
    local success = ("aplay " .. getConfigDir()) .. "/res/build_success.wav -q"
    local ____error = ("aplay " .. getConfigDir()) .. "/res/build_error.wav -q"
    vim.schedule(function()
        vim.cmd("copen")
        vim.fn.setqflist({{text = "Starting build job: " .. command}, {text = ""}}, "r")
    end)
    local stime = os.clock()
    async:new({
        command = "bash",
        args = {"-c", ("( " .. command) .. " )"},
        cwd = vim.fn.getcwd(),
        on_exit = function(j, ret)
            local etime = os.clock() - stime
            vim.schedule(function()
                vim.fn.setqflist(
                    {
                        {text = ""},
                        {text = ("Finished in " .. string.format("%.2f", etime)) .. " seconds"}
                    },
                    "a"
                )
                if ret == 0 then
                    async:new({
                        command = "aplay",
                        args = {
                            getConfigDir() .. "/res/build_success.wav",
                            "-q"
                        }
                    }):start()
                else
                    async:new({
                        command = "aplay",
                        args = {
                            getConfigDir() .. "/res/build_error.wav",
                            "-q"
                        }
                    }):start()
                end
            end)
        end,
        on_stdout = function(err, data)
            vim.schedule(function()
                vim.fn.setqflist({{text = data}}, "a")
            end)
        end,
        on_stderr = function(err, data)
            vim.schedule(function()
                vim.cmd(("caddexpr \"" .. data) .. "\"")
            end)
        end
    }):start()
end
function ____exports.build_select(opts)
    if opts == nil then
        opts = {}
    end
    local picker = pickers.new(
        opts,
        {
            prompt_title = "Build tasks",
            border = {},
            borderchars = {
                "─",
                "│",
                "─",
                "│",
                "┌",
                "┐",
                "┘",
                "└"
            },
            finder = finders.new_table({
                results = get_build_names(),
                entry_maker = function(entry)
                    return {value = entry, display = entry[1], ordinal = entry[1]}
                end
            }),
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(buf, map)
                actions.select_default:replace(function()
                    actions.close(buf)
                    local selection = action_state.get_selected_entry()
                    local build_name = selection.value[2]
                    build_runner(build_name)
                end)
                return true
            end
        }
    )
    picker:find()
end
function ____exports.build_select_lang(opts)
    if opts == nil then
        opts = {}
    end
    local picker = pickers.new(
        opts,
        {
            prompt_title = vim.bo.filetype .. " build tasks",
            border = {},
            borderchars = {
                "─",
                "│",
                "─",
                "│",
                "┌",
                "┐",
                "┘",
                "└"
            },
            finder = finders.new_table({
                results = get_build_names(vim.bo.filetype),
                entry_maker = function(entry)
                    return {value = entry, display = entry[1], ordinal = entry[1]}
                end
            }),
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(buf, map)
                actions.select_default:replace(function()
                    actions.close(buf)
                    local selection = action_state.get_selected_entry()
                    local build_name = selection.value[2]
                    build_runner(build_name)
                end)
                return true
            end
        }
    )
    picker:find()
end
local borderConf = {borderchars = {prompt = {
    "─",
    "│",
    " ",
    "│",
    "┌",
    "┐",
    "│",
    "│"
}, results = {
    "─",
    "│",
    "─",
    "│",
    "├",
    "┤",
    "┘",
    "└"
}, preview = {
    "─",
    "│",
    "─",
    "│",
    "┌",
    "┐",
    "┘",
    "└"
}}}
function ____exports.run_build_select()
    ____exports.build_select(themes.get_dropdown(borderConf))
end
function ____exports.run_build_select_lang()
    ____exports.build_select_lang(themes.get_dropdown(borderConf))
end
function ____exports.run_default_task()
    local current_language = vim.bo.filetype
    local clang = string.lower(current_language)
    local tasks = get_build_names()
    do
        local i = 0
        while i < #tasks do
            local opts = __TS__StringSplit(tasks[i + 1][2], "_")
            if #opts == 2 then
                if string.lower(opts[1]) == string.lower(clang) and string.lower(opts[2]) == "default" then
                    build_runner(tasks[i + 1][2])
                    return
                elseif string.lower(opts[1]) == "any" and string.lower(opts[2]) == "default" then
                    build_runner(tasks[i + 1][2])
                    return
                end
            end
            i = i + 1
        end
    end
    local hasLangTask = false
    do
        local i = 0
        while i < #tasks do
            local opts = __TS__StringSplit(tasks[i + 1][2], "_")
            if #opts > 0 then
                if string.lower(opts[1]) == string.lower(clang) then
                    hasLangTask = true
                end
            end
            i = i + 1
        end
    end
    if hasLangTask then
        popup(("Could not find default task for '" .. current_language) .. "'. \nPlease select task from list.", "warn", "Build")
        ____exports.run_build_select_lang()
    else
        popup(("Could not find any tasks for '" .. current_language) .. "'. \nPlease select task from list.", "warn", "Build")
        ____exports.run_build_select()
    end
end
function ____exports.run_default_run_task()
    local current_language = vim.bo.filetype
    local clang = string.lower(current_language)
    local tasks = get_build_names()
    do
        local i = 0
        while i < #tasks do
            local opts = __TS__StringSplit(tasks[i + 1][2], "_")
            if #opts == 3 then
                if string.lower(opts[1]) == string.lower(clang) and string.lower(opts[2]) == "default" and string.lower(opts[3]) == "run" then
                    build_runner(tasks[i + 1][2])
                    return
                elseif string.lower(opts[1]) == "any" and string.lower(opts[2]) == "default" and string.lower(opts[3]) == "run" then
                    build_runner(tasks[i + 1][2])
                    return
                end
            end
            i = i + 1
        end
    end
    local hasLangRunTask = false
    local hasLangTask = false
    do
        local i = 0
        while i < #tasks do
            local opts = __TS__StringSplit(tasks[i + 1][2], "_")
            if #opts == 3 then
                if string.lower(opts[1]) == string.lower(clang) and string.lower(opts[3]) == "run" then
                    hasLangRunTask = true
                end
            end
            if #opts > 0 then
                if string.lower(opts[1]) == string.lower(clang) then
                    hasLangTask = true
                end
            end
            i = i + 1
        end
    end
    if hasLangRunTask then
        popup(("Could not find default run task for '" .. current_language) .. "'. \nPlease select task from list.", "warn", "Build")
        ____exports.run_build_select_lang()
    elseif hasLangTask then
        popup(("Could not find any run tasks for '" .. current_language) .. "'. \nPlease select task from list.", "warn", "Build")
        ____exports.run_build_select_lang()
    else
        popup(("Could not find any tasks for '" .. current_language) .. "'. \nPlease select task from list.", "warn", "Build")
        ____exports.run_build_select()
    end
end
return ____exports
 end,
}
return require("justbuild", ...)
