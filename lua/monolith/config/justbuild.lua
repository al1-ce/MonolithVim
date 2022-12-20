
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

-- End of Lua Library inline imports
local ____exports = {}
local telescope_ = require("telescope")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local themes = require("telescope.themes")
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
local just = "just -f ~/.config/nvim/justfile"
local function get_build_names(lang)
    if lang == nil then
        lang = ""
    end
    local outlist = vim.fn.system(just .. " --list")
    local arr = __TS__StringSplit(outlist, "\n")
    table.remove(arr, 1)
    table.remove(arr)
    local newArr = {}
    do
        local i = 0
        while i < #arr do
            local options = __TS__StringSplit(arr[i + 1], " ")
            options = __TS__ArrayFilter(
                options,
                function(____, e) return e ~= "" end
            )
            local name = options[1]
            if string.lower(name) == string.lower(lang) or lang == "" then
                newArr[#newArr + 1] = name
            end
            i = i + 1
        end
    end
    return newArr
end
local function fix_build_names(arr_names)
    local arr = {}
    do
        local i = 0
        while i < #arr_names do
            local parts = arr_names[i + 1]:split("_")
            local out = parts[1] .. ": "
            table.remove(parts, 1)
            out = out .. table.concat(parts, " ")
            arr[#arr + 1] = {out, arr_names[i + 1]}
            i = i + 1
        end
    end
    return arr
end
local function get_build_args(build_name)
    local outshow = vim.fn.system((just .. " -s ") .. build_name)
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
            local a = vim.fn.input(arg .. ": ", "")
            argsout[#argsout + 1] = a
            i = i + 1
        end
    end
    return argsout
end
local function build_runner(build_name)
    local args = get_build_args(build_name)
    local command = (((just .. " -d . ") .. build_name) .. " ") .. table.concat(args, " ")
    local success = "aplay ~/.config/nvim/res/build_success.wav -q"
    local ____error = "aplay ~/.config/nvim/res/build_error.wav -q"
    local lcom = (((((":AsyncRun ( " .. command) .. " ) && ( ") .. success) .. " ) || ( ") .. ____error) .. " )"
    vim.cmd(lcom)
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
                results = fix_build_names(get_build_names()),
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
                results = fix_build_names(get_build_names(vim.bo.filetype)),
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
    local cmp1 = string.lower(current_language)
    local tasks = get_build_names()
    do
        local i = 1
        while i < #tasks do
            local opts = __TS__StringSplit(tasks[i + 1], "_")
            if #opts == 2 then
                if string.lower(opts[1]) == string.lower(cmp1) and string.lower(opts[2]) == "default" then
                    build_runner(tasks[i + 1])
                    return
                end
            end
            i = i + 1
        end
    end
    popup(("Could not find default task for '" .. current_language) .. "'. \nPlease select task from list.", "warn", "Build")
    ____exports.run_build_select()
end
return ____exports
 end,
}
return require("justbuild", ...)
