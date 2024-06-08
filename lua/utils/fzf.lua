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

return M

