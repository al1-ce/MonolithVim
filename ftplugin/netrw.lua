local noremap = import "map" .noremap
local nr = function(from, to)
    noremap("n", from, to, { remap = true, buffer = true, nowait = true })
end

nr("o", "%")
nr("r", "R")
nr("x", "D")
nr("q", "<C-^>")
