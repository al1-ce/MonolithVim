local function error(m) local ok, _   = pcall(require, "notify"); if not ok then vim.api.nvim_err_writeln(m) else require("notify")(m) end end
local function load(m)  local ok, err = pcall(require, m);        if not ok then error("Package \"" .. m .. "\" failed to load. \n\n" .. err) end end

return load

