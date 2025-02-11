return {
    -- project manager [ \fp ]
    {
        "al1-ce/project.nvim",
        config = function()
            local project = require("project_nvim")
            project.setup({
                show_hidden = true,
                silent_chdir = true,
                detection_methods = { "pattern" }, -- "lsp" makes it jump too much
                patterns = {
                    -- Home dir things
                    "!.xinitrc",
                    "!.bashrc",
                    -- Special
                    "!.ignore_project",
                    "!>out",
                    -- Language specific
                    ".git", ".gitignore",  -- git
                    "dub.json", "dub.sdl", -- d
                    "package.json",        -- js
                    "*.sln",               -- c#
                    -- Generic:
                    -- "src", "source",
                    -- "justfile",
                    "xmake.lua", "premake5.lua",
                    "meson.build", "build.ninja",
                    ".vscode",

                    -- Do not enable since it can be in subdirs
                    -- "Makefile", "CmakeLists.txt",
                },
            })
        end
    },

}
