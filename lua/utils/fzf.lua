local function reverse(tab)
    for i = 1, #tab / 2, 1 do
        tab[i], tab[#tab - i + 1] = tab[#tab - i + 1], tab[i]
    end
    return tab
end

local function deleteProject(paths)
    for _, fpath in ipairs(paths) do
        local choice = vim.fn.confirm("Delete '" .. fpath .. "' from project list?", "&Yes\n&No", 2)

        if choice == 1 then
            require("project_nvim.utils.history").delete_project({ value = fpath })
        end
    end
end

local M = {}

M.FzfProjects = function()
    require("fzf-lua").fzf_exec(
        reverse(require("project_nvim").get_recent_projects()),
        {
            prompt = " ",
            -- fzf_opts = {['--layout'] = 'reverse'},
            actions = {
                ['default'] = function(selected, opts) require("fzf-lua").files({ cwd = selected[1] }) end,
                ["ctrl-d"] = deleteProject,
                ["ctrl-w"] = function(selected, opts) vim.api.nvim_set_current_dir(selected[1]) end,
            }
        }
    )
end

M.set_colorscheme = function(selected, opts)
    -- print(vim.inspect(selected[1]))
    -- TODO: apply also to lualine
    local colorscheme = selected[1]:match("^[^:]+")
    pcall(function() vim.cmd("colorscheme " .. colorscheme) end)
    local config_loc = vim.fn.fnamemodify(vim.fn.expand("$HOME"), ":p:h") .. "/.config/neovim-theme.lua"
    vim.loop.fs_open(config_loc, "w", 432, function(err, fd)
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.loop.fs_write(fd, "vim.cmd.colorscheme('" .. selected[1] .. "')", nil, function()
            ---@diagnostic disable-next-line: param-type-mismatch
            vim.loop.fs_close(fd)
        end)
    end)
end

M.source_colorscheme = function()
    local config_loc = vim.fn.fnamemodify(vim.fn.expand("$HOME"), ":p:h") .. "/.config/neovim-theme.lua"
    local f = io.open(config_loc, "r")
    if f ~= nil then
        io.close(f)
        vim.cmd("source " .. config_loc)
    end
end

return M
