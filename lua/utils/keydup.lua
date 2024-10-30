local vim_keymap_set = vim.keymap.set

-- function __FILE__() return debug.getinfo(2, 'S').source end
-- function __LINE__() return debug.getinfo(2, 'l').currentline end
-- function __FUNC__() return debug.getinfo(2, 'n').name end
-- function __TRACE__() return debug.traceback() end

local ends_with = function(this, pattern)
    return pattern == "" or this:sub(- #pattern) == pattern
end

local key_arr = {
    [""] = {},
    ["n"] = {},
    ["v"] = {},
    ["s"] = {},
    ["x"] = {},
    ["o"] = {},
    ["!"] = {},
    ["i"] = {},
    ["l"] = {},
    ["c"] = {},
    ["t"] = {},
}

local function warn(msg)
    vim.notify(msg, vim.log.levels.WARN)
end

local _call_stack_count = 4

local function handle_key(mode, lhs, rhs, opts)
    coroutine.resume(coroutine.create(function()
    if ends_with(debug.getinfo(3, 'S').source, "lazy/core/handler/keys.lua") and debug.getinfo(3, 'l').currentline == 121 then return end
    local rhname = vim.inspect(rhs)
    if key_arr[mode][lhs] then
        local key = key_arr[mode][lhs]
        if not opts or not opts.buffer then
            print("==========================================================")
            warn("Duplicate keymap for '" .. lhs .. "' mapped to " .. rhname .. ". Previous mapping is " .. key.rhs)
            warn("Original  keymap defined at:")
            for i = 1, _call_stack_count, 1 do
                if not key.files[i] then break end
                warn("    " .. key.files[i] .. ":" .. tostring(key.lines[i]))
            end
            warn("Offencing keymap defined at:")
            for i = 1, _call_stack_count, 1 do
                if not debug.getinfo(2 + i, 'S') then break end
                local _file = debug.getinfo(2 + i, 'S').short_src
                if _file == "[C]" then break end
                local _line = debug.getinfo(2 + i, 'l').currentline
                warn("    " .. _file .. ":" .. tostring(_line))
            end
            print("==========================================================")
            vim.fn.confirm("Press Enter to continue.", "", 0)
        end
    end
    key_arr[mode][lhs] = {
        rhs = rhname,
        files = { },
        lines = { },
    }
    for i = 1, _call_stack_count, 1 do
        if not debug.getinfo(2 + i, 'S') then break end
        local file = debug.getinfo(2 + i, 'S').short_src
        local line = debug.getinfo(2 + i, 'l').currentline
        table.insert(key_arr[mode][lhs].files, file)
        table.insert(key_arr[mode][lhs].lines, line)
    end
    end))
end

---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
    if not lhs then return end
    if type(mode) == "table" then
        for _, m in ipairs(mode) do handle_key(m, lhs, rhs, opts) end
    else
        handle_key(mode, lhs, rhs, opts)
    end
    vim_keymap_set(mode, lhs, rhs, opts)
end


