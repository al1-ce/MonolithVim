local module = require("module")
_G.include = function(mod) module.load(mod) end
