local function map(from, to) vim.keymap.set("n", from, to, { noremap = true, silent = true, buffer = true }) end

local function starts_with(str, pat) return str:sub(1, #pat) == pat end

local t = vim.w.quickfix_title

if t == nil then return end

-- custom qf and loc that are used as replacement for fzf

if starts_with(t, ":lexpr ['--") then
    map("<cr>", "<cmd>.ll<cr><cmd>wincmd p<cr><cmd>q<cr>")
end

if starts_with(t, ":cexpr ['--") then

end
