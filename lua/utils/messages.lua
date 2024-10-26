local can_load = require("module").can_load

local M = {}

local hl_group = {
    OFF = "Comment",
    INFO = "Normal",
    WARN = "Warning",
    DEBUG = "Debug",
    ERROR = "Error",
    TRACE = "Trace"
}

M.override_messages = function()
    if can_load("notify") then
        local notify = require("notify")

        M.notify = vim.notify
        M.nvim_err_write = vim.api.nvim_err_write
        M.nvim_err_writeln = vim.api.nvim_err_writeln
        M.nvim_echo = vim.api.nvim_echo

        vim.notify = notify

        vim.api.nvim_err_write = function(message)
            notify(message, vim.log.levels.ERROR)
        end

        vim.api.nvim_err_writeln = function(message)
            notify(message, vim.log.levels.ERROR)
        end

        vim.api.nvim_echo = function(chunks, history, opts)
            local message = ""
            for i, v in ipairs(chunks) do
                message = message .. "\n" .. v[1]
            end
            notify(message, vim.log.levels.INFO)
        end

        vim.api.nvim_create_user_command(
            'Messages',
            function()
                local hist = {}

                for _, v in pairs(notify.history()) do
                    for _, m in pairs(v.message) do
                        if m == "" then goto continue end
                        table.insert(hist, { m .. '\n', hl_group[v.level] })
                        ::continue::
                    end
                end

                M.nvim_echo({{ "--- Neovim Messages: ---\n", "Comment"}}, false, {})
                vim.cmd("messages")
                M.nvim_echo({{ "\n--- Notify Messages: ---\n", "Comment"}}, false, {})
                M.nvim_echo(hist, false, {})
            end,
            {})
    end
end

return M
