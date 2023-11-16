local org = require("orgmode")
local bul = require("org-bullets")

org.setup_ts_grammar()

org.setup({
    org_agenda_files = "~/.orgmode/**/*",
    org_default_notes_file = "~/.orgmode/refile.org",
    org_todo_keywords = { "TODO", "DOING", "|", "DONE" },
    win_border = { "┌", " ", "┐", " ", "┘", " ", "└", " " },

    org_startup_folded = "showeverything",

    mappings = {
        global = {
            org_agenda = "<Leader>oA",
            org_capture = "<Leader>oC",
        }
    },
})

bul.setup({
    concealcursor = false, -- If false then when the cursor is on a line underlying characters are visible
    symbols = {
        -- list symbol
        list = "•",
        -- headlines can be a list
        headlines = { "◉", "○", "✸", "✿" },
        -- headlines = { "", "", "", "", "", "" },
        -- or a function that receives the defaults and returns a list
        -- headlines = function(default_list)
        --     table.insert(default_list, "♥")
        --     return default_list
        -- end,
        checkboxes = {
            half = { "", "OrgTSCheckboxHalfChecked" },
            done = { "⛝", "OrgDone" },
            todo = { "⛶", "OrgTODO" },
        },
    }
})
