local M = {}

M.line_len = function(c_row)
    return #(vim.api.nvim_buf_get_lines(0, c_row, c_row + 1, false)[1])
end

M.delete_char = function(is_backspace)
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local c_row = cursor_pos[1] - 1
    local c_col = cursor_pos[2]
    local row_count = vim.api.nvim_buf_line_count(0)
    local col_count = M.line_len(c_row)
    -- vim.notify(vim.inspect(vim.api.nvim_buf_get_lines(0, c_row, c_row + 1, false)))

    if is_backspace == 1 then
        if c_row == 0 and c_col == 0 then return end
        if c_col == 0 then
            vim.api.nvim_buf_set_text(0, c_row - 1, M.line_len(c_row - 1), c_row, c_col, {})
        else
            vim.api.nvim_buf_set_text(0, c_row, c_col - 1, c_row, c_col, {})
        end
    else
        if c_row == row_count - 1 and c_col == col_count then return end
        if c_col == col_count then
            vim.api.nvim_buf_set_text(0, c_row, col_count, c_row + 1, 0, {})
        else
            vim.api.nvim_buf_set_text(0, c_row, c_col, c_row, c_col + 1, {})
        end
    end
    -- bs - start higher then end
    -- dle - invalid end_col: out of range
end

M.lineHome = function()
    local x = vim.fn.col('.')
    vim.fn.execute('normal ^')
    if x == vim.fn.col('.') then
        vim.fn.execute('normal 0')
    end
end

M.lineEnd = function()
    local x = vim.fn.col('.')
    vim.fn.execute('normal g_')
    vim.fn.execute("normal l")
    if x == vim.fn.col('.') then
        vim.fn.execute('normal g$')
    end
end

M.cd_filedir = function()
    local cdir = vim.fn.expand("%:p:h")
    vim.api.nvim_set_current_dir(cdir)
    vim.notify(vim.fn.getcwd())
end

M.open_link_vis = function()
    vim.fn.feedkeys('"vy', "x")
    vim.fn.feedkeys(vim.keycode("<esc>"), "x")
    local s = vim.fn.getreg("v")
    vim.ui.open(vim.fn.expand(s))
    vim.notify(s)
end

M.open_link_norm = function()
    -- "x" makes it fast
    vim.fn.feedkeys("viW", "x")
    M.open_link_vis()
end

return M

