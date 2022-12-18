local M = {};
local Hydra = require('hydra')

function M.hydraCallback(name) 
    return function ()
        Hydra.activate(require('monolith.config.hydra.' .. name).hydra())
    end
end

return M;