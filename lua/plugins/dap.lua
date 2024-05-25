local sysdep = require("utils.sysdep")
---@diagnostic disable: undefined-field, need-check-nil, redundant-parameter
return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
        },
        cond = sysdep({ "pgrep", "gdb" }),
        enabled = true,
        config = function()
            -- █▀▄ ▄▀█ █▀█
            -- █▄▀ █▀█ █▀▀
            local dap = require('dap')

            dap.adapters.lldb = function(cb, config)
                local adapter = dap.adapters.cpp
                if config.request == 'attach' and config.program then
                    local terminal = dap.defaults[config.type].external_terminal
                    local full_args = {}
                    vim.list_extend(full_args, terminal.args or {})
                    table.insert(full_args, config.program)
                    vim.list_extend(full_args, config.args or {})
                    local opts = {
                        args = full_args,
                        detached = true
                    }
                    local handle
                    local pid_or_err
                    handle, pid_or_err = vim.loop.spawn(terminal.command, opts, function(code)
                        handle:close()
                        if code ~= 0 then
                            print('Terminal process exited', code, 'running', terminal.command, vim.inspect(full_args))
                        end
                    end)
                    if not handle then
                        print('Could not launch process', terminal.command)
                    else
                        print('Launched external terminal', pid_or_err)
                        while not config.pid do -- Adding a timeout or something might make sensedo
                            ---@diagnostic disable-next-line: inject-field
                            config.pid = tonumber(vim.fn.system({ 'pgrep', '-P', pid_or_err }))
                        end
                        print('Launched', config.program, 'within terminal with PID', config.pid)
                        ---@diagnostic disable-next-line: inject-field
                        config.program = nil
                    end
                end
                ---@diagnostic disable-next-line: param-type-mismatch
                cb(adapter)
            end

            dap.adapters.cpp = {
                type = 'executable',
                command = '/bin/lldb-vscode', -- adjust as needed, must be absolute path
                name = 'lldb',
                -- env = {
                --   LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "NO"
                -- },
            }
            dap.adapters.d = dap.adapters.cpp
            dap.adapters.c = dap.adapters.cpp
            -- dap.defaults.fallback.force_external_terminal = true
            dap.defaults.fallback.external_terminal = {
                -- dap.defaults.cpp.external_terminal = {
                -- command = "/usr/bin/alacritty",
                -- args = {'-e', '--hold'}
                command = "/bin/wezterm",
                args = { '--hold' }
            }
            dap.defaults.d.external_terminal = dap.defaults.fallback.external_terminal
            dap.defaults.cpp.external_terminal = dap.defaults.fallback.external_terminal
            dap.defaults.c.external_terminal = dap.defaults.fallback.external_terminal

            local function split(inputstr, sep)
                if sep == nil then
                    sep = "%s"
                end
                local t = {}
                for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
                    table.insert(t, str)
                end
                return t
            end

            dap.configurations.cpp = { {
                name = 'Launch',
                -- type = 'gdb',
                type = 'lldb',
                -- request = 'attach',
                request = 'launch',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                -- args = {},
                args = function()
                    return split(vim.fn.input('Arguments (separated by $!): '), "$!")
                end,
                -- runInTerminal = true
                -- console = "externalTerminal",
                -- externalTerminal = true,
            } }

            dap.configurations.d = dap.configurations.cpp
            dap.configurations.c = dap.configurations.cpp

            vim.api.nvim_create_user_command('DapBreak', function() vim.cmd("DapToggleBreakpoint") end, {})

            -- █▀▄ ▄▀█ █▀█ █ █  █
            -- █▄▀ █▀█ █▀▀ █▄█  █
            local dapui = require("dapui")

            ---@diagnostic disable-next-line: missing-fields
            dapui.setup({
                layouts = {
                    {
                        elements = {
                            -- { id = "scopes", size = 2 },
                            "breakpoints",
                            "watches",
                            -- "stacks",
                            "scopes",
                            -- "repl"
                        },
                        size = 25,
                        position = "left"
                    }
                },
                controls = {
                    -- Requires Neovim nightly (or 0.8 when released)
                    enabled = true,
                    -- Display controls in this element
                    element = "breakpoints",
                    icons = {
                        pause = "",
                        play = "",
                        step_into = "",
                        step_over = "",
                        step_out = "",
                        step_back = "",
                        run_last = "",
                        terminate = "",
                    },
                },
            })
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.after.event_breakpoint["dapui_config"] = function()
                dapui.open()
            end
            -- Next two causes some trouble, might turn them back on later
            dap.listeners.before.event_terminated["dapui_config"] = function()
                -- dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                -- dapui.close()
            end

            vim.api.nvim_create_user_command('DapUI', function() dapui.toggle() end, {})
        end
    }
}
