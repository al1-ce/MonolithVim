local module = require("module")
_G.import = function(mod) return module.load(mod:gsub("/", ".")) or {} end
_G.include = function(mod) module.load(mod:gsub("/", ".")) end
