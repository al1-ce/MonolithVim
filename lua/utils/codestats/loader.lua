local open = io.open

local function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

local function read_file(path)
    local file = open(path, "rb") -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end

local codestats = os.getenv("HOME") .. "/.config/codestats.lua"

local notify = require("notify");

local codestatsopts = {
    title="code::stats",
    timeout = 500,
}

if (file_exists(codestats)) then
    require('utils.codestats.init').setup({
        token = read_file(codestats):sub(1, -2)
    })
    -- require("notify")(read_file(codestats), "warn", {title="Title"})
    -- notify("Successfully connected", "info", codestatsopts)
else
    notify("Missing API key", "info", codestatsopts)
    -- require("notify")("not", "warn", {title="Title"})
end

