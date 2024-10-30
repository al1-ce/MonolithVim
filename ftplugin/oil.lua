local oil = import "oil"

local ends_with = function(this, pattern)
    return pattern == "" or this:sub(- #pattern) == pattern
end

local function is_one_of(n, e)
    for _, ext in ipairs(e) do
        if ends_with(n, ext) then return true end
    end
    return false
end

local function is_executable(file)
    local v = vim.api.nvim_exec2("!test -x " .. file .. " && echo 'executable'", { output = true })
    if string.find(v.output:gsub(".+\r\n\n", ""), "executable", 0, true) then
        return true;
    else
        return false;
    end
end

local extensions = {
    ".png", ".jpg", ".jpeg", ".gif",
}

vim.keymap.set("n", "<C-cr>", function()
    local item = oil.get_cursor_entry()
    if item == nil then return end
    if item.type ~= "file" then return end
    local name = item.name
    local fpath = vim.fn.resolve(oil.get_current_dir(0) .. "/" .. name)

    if is_one_of(name, extensions) then
        vim.system({ "feh", fpath })
        return
    end

    if is_executable(fpath) then
        -- vim.system({ fpath })
        vim.cmd("!" .. fpath)
        return
    end

    vim.notify("Could not find handler for selected file", vim.log.levels.warn)
end, { silent = true, noremap = true, buffer = true, desc = "Execute handler for selected file" })

