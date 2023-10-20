local function load(m)
  local ok, err = pcall(require, m)
  if not ok then
      vim.api.nvim_err_writeln("Package \"" .. m .. "\" failed to load. \n\n" .. err)
  end
end

load('monolith.core.settings')
load('monolith.core.plugins')

-- speeds up plugin load time
load('impatient')

load('monolith.plugins.loader')

load('monolith.core.mappings')

load('monolith.core.colorscheme')
load('monolith.core.autocmd')
