return function(module)
    local ok, _   = pcall(require, module)
    if not ok then
        return false
    else
        return true
    end
end
