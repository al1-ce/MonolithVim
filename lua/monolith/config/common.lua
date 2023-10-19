local function load(m)
  local ok, err = pcall(require, "monolith.config.common." .. m)
  if not ok then
      vim.api.nvim_err_writeln("Package \"" .. m .. "\" failed to load. \n\n" .. err)
  end
end

-- Plugin setup
load("align")
load("async")
load("codestats")
load("colorizer")
load("easymotion")
load("glow")
load("illuminate")
load("lastplace")
load("link-visitor")
load("move")
load("neoclip")
load("neodev")
load("notify")
load("nvim-toggler")
load("pqf")
load("range-highlight")
load("remember-me")
load("sessions")
load("smart-splits")
load("spectre")
load("toggleterm")
load("undotree")
load("winshift")

