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

local codestats_setup = import 'after.codestats.setup'

local codestatsopts = {
    title="code::stats",
    timeout = 500,
}

if (file_exists(codestats)) then
    codestats_setup.setup({
        token = read_file(codestats):sub(1, -2)
    })
else
    vim.notify("Missing API key", vim.log.levels.INFO, codestatsopts)
end

