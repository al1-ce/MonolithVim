---@diagnostic disable: duplicate-set-field
local can_load = require("module").can_load

local M = {}

M.setup = function () end

if not can_load("fzf-lua") then return M end

local fzf = require("fzf-lua")
local fzfutil = require("fzf-lua.utils")
local builtin = require("fzf-lua.previewer.builtin")
local colsch = require("utils.colorscheme")

-- global cool funcs
require("jsfunc")

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

local function inspect(val)
    vim.notify(vim.inspect(val))
end

local function get_color(group, attr)
    return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
end

local function get_hl_group(group)
    local gr_id = vim.fn.synIDtrans(vim.fn.hlID(group))
    return {
        fg = vim.fn.synIDattr(gr_id, "fg#"),
        bg = vim.fn.synIDattr(gr_id, "bg#"),
        sp = vim.fn.synIDattr(gr_id, "sp#"),
        bold = vim.fn.synIDattr(gr_id, "bold") == "1",
        standout = vim.fn.synIDattr(gr_id, "standout") == "1",
        underline = vim.fn.synIDattr(gr_id, "underline") == "1",
        undercurl = vim.fn.synIDattr(gr_id, "undercurl") == "1",
        underdouble = vim.fn.synIDattr(gr_id, "underdouble") == "1",
        underdotted = vim.fn.synIDattr(gr_id, "underdotted") == "1",
        underdashed = vim.fn.synIDattr(gr_id, "underdashed") == "1",
        strikethrough = vim.fn.synIDattr(gr_id, "strikethrough") == "1",
        italic = vim.fn.synIDattr(gr_id, "italic") == "1",
        reverse = vim.fn.synIDattr(gr_id, "reverse") == "1",
        nocombine = vim.fn.synIDattr(gr_id, "nocombine") == "1",
        ctermfg = vim.fn.synIDattr(gr_id, "ctermfg"),
        ctermbg = vim.fn.synIDattr(gr_id, "ctermbg"),
    }
end

---@param actions table
---@param opts table?
M.create_picker = function(actions, opts)
    actions = actions or {}
    opts = vim.tbl_extend("force", { actions = actions }, opts or {})

    local c_opts = opts
    return function(list)
        fzf.fzf_exec(list, c_opts)
    end
end

---@alias preview_func function(string, number)

---@param actions table
---@param populate_preview_func preview_func
---@param opts table?
M.create_picker_preview = function(actions, populate_preview_func, opts)
    opts = vim.tbl_extend("force", { actions = actions }, opts or {})

    local Previewer = builtin.base:extend()

    function Previewer:new(o, _opts, fzf_win)
        Previewer.super.new(self, o, _opts, fzf_win)
        setmetatable(self, Previewer)
        return self
    end

    function Previewer:populate_preview_buf(entry_str)
        local bufnr = self:get_tmp_buffer()
        populate_preview_func(entry_str, bufnr)
        self:set_preview_buf(bufnr)
        if type(self.title) == "string" then self.win:update_title(" " .. self.title .. " ") end
        self.win:update_scrollbar()
    end

    function Previewer:gen_winopts()
        local new_winopts = {
            -- wrap    = false,
            -- number  = false
            cursorline = false,
        }
        return vim.tbl_extend("force", self.winopts, new_winopts)
    end

    opts.previewer = Previewer
    return M.create_picker(actions, opts)
end

local hl_ns_id = vim.api.nvim_create_namespace("fzf_projects_win_hl")

local function parse_line_hl(line)
    local ret = {}
    if line:starts_with("[1;34m") then
        ret.hl = "Function"
    elseif line:starts_with("[1;32m") then
        ret.hl = "String"
    elseif line:starts_with("[35m") then
        ret.hl = "Float"
    elseif line:starts_with("[1;4;33m") then
        ret.hl = "Special"
    elseif line:starts_with("[1;33m") then
        ret.hl = "Special"
    elseif line:starts_with("[") then
        ret.hl = "Error"
    else
        ret.hl = "Normal"
    end
    ret.text = fzfutil.strip_ansi_coloring(line)
    if ret.text:ends_with("*") then
        ret.text = ret.text:sub(1, #ret.text - 1)
    end
    -- ret.text = line
    -- TODO: asdf
    return ret
end

local function get_dir_entries(dir)
    return vim.fn.split(
        vim.fn.system("eza -1a --color=always --no-symlinks --git-ignore --group-directories-first -F=always " .. dir),
        "\n"
    )
end

M.populate_preview_eza = function(entry_str, bufnr)
    local entries = get_dir_entries(entry_str)
    for i, entry in ipairs(entries) do
        local l = parse_line_hl(entry)
        vim.api.nvim_buf_set_lines(bufnr, i - 1, i + 1, false, { l.text })
        vim.api.nvim_buf_set_extmark(bufnr, hl_ns_id, i - 1, 0, {
            line_hl_group = l.hl,
            priority = 100,
        })
    end
end

local project_picker = M.create_picker_preview(
    {
        ['default'] = function(selected, opts) fzf.files({ cwd = selected[1] }) end,
        ["alt-d"] = deleteProject,
        ["alt-w"] = function(selected, opts) vim.api.nvim_set_current_dir(selected[1]) end,
    },
    M.populate_preview_eza,
    {
        prompt = "> ",
        winopts = {
            title = "Projects",
            title_pos = "center",
            preview = { title = "Listing", title_pos = "center" }
        },
    }
)

M.FzfProjects = function()
    project_picker(reverse(require("project_nvim").get_recent_projects()))
end

M.setup = function()
    vim.api.nvim_create_user_command("FzfLuaProjects", M.FzfProjects, {})

    vim.api.nvim_create_user_command("Colorschemes", function()
        require("fzf-lua.providers.colorschemes").colorschemes({
            actions = {
                ["default"] = function(selected, opts) colsch.set(selected[1]) end
            }
        })
    end, {})
end

return M
