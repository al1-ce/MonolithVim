local function error(m) local ok, _   = pcall(require, "notify"); if not ok then vim.api.nvim_err_writeln(m) else require("notify")(m, "error") end end
return error
