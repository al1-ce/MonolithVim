local function load(m)
    local ok, err = pcall(require, m)
    if not ok then
        require("utils.error")("Package \"" .. m .. "\" failed to load. \n\n" .. err)
    end
end

return load
