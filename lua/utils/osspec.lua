---@diagnostic disable: undefined-global
local function os_spec(linux, windows, mac)
    local os_name, os_arch = require("utils.getos").get_os_name()
    if os_name == "Linux" then return linux end
    if os_name == "BSD" then return linux end
    if os_name == "Solaris" then return linux end
    if os_name == "Windows" then return windows end
    if os_name == "Mac" then return mac end
    if os_name == "Other" then return require("utils.error")("OS Specific: Unknown OS") end
end

return os_spec

