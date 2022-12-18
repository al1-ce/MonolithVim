local M = {}

function M.passAllow() return {
    color = 'blue',
    invoke_on_body = true,
    hint = {
        border = 'solid',
        position = 'middle-right',
    }
} end

function M.passBlock() return {
    color = 'teal',
    invoke_on_body = true,
    hint = {
        border = 'solid',
        position = 'middle-right',
    }
} end

function M.persistAllow() return {
    color = 'pink',
    invoke_on_body = true,
    hint = {
        border = 'solid',
        position = 'bottom',
    }
} end

function M.persistBlock() return {
    color = 'amaranth',
    invoke_on_body = true,
    hint = {
        border = 'solid',
        position = 'middle',
    }
} end

function M.persistQuit() return {
    color = 'red',
    invoke_on_body = true,
    hint = {
        border = 'solid',
        position = 'bottom',
    }
} end

function M.persistQuitMiddle() return {
    color = 'red',
    invoke_on_body = true,
    hint = {
        border = 'solid',
        position = 'middle',
    }
} end

return M