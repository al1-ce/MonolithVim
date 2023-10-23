local g = vim.g

-- Make Ranger replace Netrw and be the file explorer
g.rnvimr_enable_ex = 1

-- Make Ranger to be hidden after picking a file
g.rnvimr_enable_picker = 1

-- Replace `$EDITOR` candidate with this command to open the selected file
g.rnvimr_edit_cmd = 'drop'

-- Disable a border for floating window
-- g.rnvimr_draw_border = 0

-- Hide the files included in gitignore
-- g.rnvimr_hide_gitignore = 1

-- Change the border's color
-- g.rnvimr_border_attr = {fg = 14, bg = -1}

-- Make Neovim wipe the buffers corresponding to the files deleted by Ranger
g.rnvimr_enable_bw = 1

-- Add a shadow window, value is equal to 100 will disable shadow
g.rnvimr_shadow_winblend = 100

-- Draw border with both
g.rnvimr_ranger_cmd = {'ranger', '.'}

-- Link CursorLine into RnvimrNormal highlight in the Floating window

local opts = { noremap = true, silent = true }

local keymap = vim.keymap

-- vim.keymap.set("n", "<leader>r", "<CMD>RnvimrToggle<CR>", { noremap = true, silent = true })

local function setKeymapFiletype(ft, name, mode, map, action)
    vim.api.nvim_create_autocmd('FileType', {
        pattern = ft,
        group = vim.api.nvim_create_augroup(name, {clear = true}),
        callback = function()
            keymap.set(mode, map, action, {silent = true, buffer = true})
        end
    })
end

-- setKeymapFiletype('rnvimr', 'RnvimrToggleQ', 'n', 'q', '<cmd>RnvimrToggle<cr>')
setKeymapFiletype('rnvimr', 'RnvimrToggleEsc', 't', '<Esc>', '<cmd>RnvimrToggle<cr>')


