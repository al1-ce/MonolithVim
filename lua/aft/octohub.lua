
---@diagnostic disable: lowercase-global
local utils     = require("utils")
local fzf       = require("fzf-lua")
local octoconf  = require("octohub.config")

local fzfutil   = require("plf.fzf")
local path_file = require("lib.fil")
local path_path = require("lib.pth")
local is_dir    = path_file.is_dir
local list_dir  = path_path.list_dir

local proj_dir = vim.fn.fnamemodify(octoconf.config.projects_dir, ":p")

function populate_preview(entry_str, bufnr)
    fzfutil.populate_preview_eza(proj_dir .. "/" .. entry_str, bufnr)
end

local repo_picker = fzfutil.create_picker_preview(
    {
        ['default'] = function(selected, opts) fzf.files({ cwd = proj_dir .. "/" .. selected[1] }) end,
        ["alt-d"] = function(selected, opts)
            local del = vim.fn.confirm("Do you want to delete " .. selected[1], "&Yes\n&No")
            if del then vim.fn.delete(proj_dir .. "/" .. selected[1], "rf") end
        end,
        ["alt-w"] = function(selected, opts) vim.api.nvim_set_current_dir(proj_dir .. "/" .. selected[1]) end,
    },
    populate_preview,
    {
        prompt = "> ",
        winopts = {
            title = "Cloned Repos",
            title_pos = "center",
            preview = { title = "Listing", title_pos = "center" }
        },
    }
)

function show_repo_list()
    local userlist = list_dir(proj_dir)
    local repolist = {}
    for _, user in ipairs(userlist) do
        if is_dir(user) then
            local repos = list_dir(user)
            for _, repo in ipairs(repos) do
                if is_dir(repo) then
                    table.insert(repolist, vim.fn.fnamemodify(user, ":t") .. "/" .. vim.fn.fnamemodify(repo, ":t"))
                end
            end
            if #repos == 0 then
                table.insert(repolist, vim.fn.fnamemodify(user, ":t") .. "/")
            end
        end
    end
    repo_picker(repolist)
    -- inspect(repolist)
end

vim.api.nvim_create_user_command("OctoClearCache", function(opts)
    ---@diagnostic disable-next-line: param-type-mismatch
    utils.clear_cache(false);
end, { nargs = 0 })

vim.api.nvim_create_user_command("OctoRepoList", show_repo_list, { nargs = 0 })

vim.keymap.set("n", "<leader>rm", "<cmd>OctoRepos<cr>", { noremap = true, silent = true, desc = "[R]epos by [M]e" })
vim.keymap.set("n", "<leader>rl", "<cmd>OctoRepoList<cr>",
    { noremap = true, silent = true, desc = "Cloned [R]epos [L]ist" })
vim.keymap.set("n", "<leader>rw", "<cmd>OctoRepoWeb<cr>",
    { noremap = true, silent = true, desc = "Open current [R]epo in [W]eb" })

vim.keymap.set("n", "<leader>gp", function()
    local uname = vim.fn.input("[Profile] Enter Github Username: ", "")
    vim.cmd("OctoProfile " .. uname)
end, { noremap = true, silent = false, desc = "Open [G]ithub [P]rofile (empty for yours)" })

vim.keymap.set("n", "<leader>ru", function()
    local uname = vim.fn.input("[Repositories] Github Username (empty for yours): ", "")
    vim.cmd("OctoRepos " .. uname)
end, { noremap = true, silent = false, desc = "Show [R]epos by [U]ser" })

vim.keymap.set("n", "<leader>rf", function()
    local uname = vim.fn.input("[Find Repo] Github Username (empty for yours): ", "")
    local rname = vim.fn.input("[Find Repo] Repository Name: ", "")
    if rname == "" then
        vim.notify("Must provide repository name", vim.log.levels.WARN); return;
    end
    vim.cmd("OctoRepo " .. uname .. " " .. rname)
end, { noremap = true, silent = false, desc = "[R]epo [F]ind" })


