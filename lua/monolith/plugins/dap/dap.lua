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
                config.pid = tonumber(vim.fn.system({ 'pgrep', '-P', pid_or_err }))
            end
            print('Launched', config.program, 'within terminal with PID', config.pid)
            config.program = nil
        end
    end
    cb(adapter)
end

dap.adapters.cpp = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
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
    command = "/usr/bin/kitty",
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
