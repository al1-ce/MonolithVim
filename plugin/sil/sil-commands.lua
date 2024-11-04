vim.api.nvim_create_user_command('Spell', function()
    vim.o.spell = not vim.o.spell
    if vim.o.spell then
        vim.notify("Turning spelling on")
    else
        vim.notify("Turning spelling off")
    end
end, {})

vim.api.nvim_create_user_command('Wrap', function()
    vim.o.wrap = not vim.o.wrap
    if vim.o.wrap then
        vim.notify("Turning wrap on")
    else
        vim.notify("Turning wrap off")
    end
end, {})

vim.api.nvim_create_user_command('Tabs', function()
    vim.opt.expandtab = not vim.opt.expandtab
    if vim.opt.expandtab then
        vim.notify("Using spaces for indent")
    else
        vim.notify("Using tabs for indent")
    end
end, {})

local is_center = false
vim.api.nvim_create_user_command("KeepCenter", function()
    if is_center then
        vim.keymap.del("n", "j")
        vim.keymap.del("n", "k")
    else
        vim.keymap.set("n", "j", "jzz", { silent = true, noremap = true })
        vim.keymap.set("n", "k", "kzz", { silent = true, noremap = true })
    end
    is_center = not is_center
end, {})

vim.api.nvim_create_user_command("OpenWith", function (opts)
    local args = opts.fargs
    table.insert(args, vim.fn.expand("%:p"))
    vim.system(args)
end, { range = false, nargs = "+" })

vim.api.nvim_create_user_command("SetColorscheme", function (opts)
    local args = opts.fargs[1]
    require("lib.col").set(args)
end, { range = false, nargs = 1 })


