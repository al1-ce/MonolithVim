local load = require("loader")

load('monolith.core.settings')
load('monolith.core.plugins')

-- speeds up plugin load time
load('impatient')

load('monolith.plugins.loader')

load('monolith.core.mappings')

load('monolith.core.colorscheme')

load("monolith.plugins.utils.alpha")

