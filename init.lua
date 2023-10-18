local function prequire(m) 
  local ok, err = pcall(require, m) 
  if not ok then
      error("Package \"" .. m .. "\" failed to load.")
      return nil, err 
  end
  return err
end

prequire('monolith.core.settings')
prequire('monolith.core.plugins')

prequire('impatient')

prequire('monolith.config.common')
prequire('monolith.config.tabby')
-- require('monolith.config.yabs')
prequire('monolith.config.wilder')
prequire('monolith.config.lualine')
prequire('monolith.config.easypick')
prequire('monolith.config.colorpicker')
prequire('monolith.config.sidebar')
prequire('monolith.config.scrollbar')
prequire('monolith.config.dap')
prequire('monolith.config.comment')
prequire('monolith.config.lsp')
prequire('monolith.config.lsp-server')
prequire('monolith.config.tree')
prequire('monolith.config.telescope')
prequire('monolith.config.minimap')
prequire('monolith.config.hydra')
prequire('monolith.config.alpha')
-- require('monolith.config.dashboard')

prequire('monolith.core.colorscheme')
prequire('monolith.core.mappings')
prequire('monolith.core.autocmd')
