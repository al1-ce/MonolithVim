local easypick = require("easypick")

-- only required for the example to work
local base_branch = "master"

local justFile = vim.fn.expand('~/.config/nvim/justfile:p:h'):sub(0,-5)

easypick.setup({
    pickers = {
        -- https://github.com/axkirillov/easypick.nvim/wiki
        {
            name = "ls",
            command = "ls",
            previewer = easypick.previewers.default()
        },
        {
            name = "changed_files",
            command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
            previewer = easypick.previewers.branch_diff({ base_branch = base_branch })
        },
        {
            name = "conflicts",
            command = "git diff --name-only --diff-filter=U --relative",
            previewer = easypick.previewers.file_diff()
        },
        {
            name = "just",
            command = "just -l -f " .. justFile,
            previewer = easypick.previewers.default()
        },
    }
})
