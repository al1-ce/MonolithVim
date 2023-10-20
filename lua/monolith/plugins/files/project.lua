
require("project_nvim").setup({
    show_hidden = true,
    silent_chdir = true,
    detection_methods = {"pattern"}, -- "lsp" makes it jump too much
    patterns = {
        "dub.json", "dub.sdl", -- d
        ".git", ".gitignore", -- git
        "src", "source", -- general
        "package.json", -- js
        "*.sln", -- c#
    }
})

