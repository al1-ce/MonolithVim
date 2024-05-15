local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

-- local dashboard = require("alpha.themes.dashboard")
local dashboard = require("alpha.themes.startify")

local header = {
	type = "text",
	val = "",
	opts = {
		position = "center",
		hl = "Text",
	}
}
-- 東亜重工
-- 統和機構
-- 

local date = os.date(" %A, %b %d")

local heading = {
	type = "text",
	-- val = " ＴＯＨＡ ＨＥＡＶＹ ＩＮＤＵＳＴＲＩＥＳ     ∴ ",
	val = " T O H A  H E A V Y  I N D U S T R I E S  ∴ ",
	-- val = "𝗧𝗢𝗛𝗔 𝗛𝗘𝗔𝗩𝗬 𝗜𝗡𝗗𝗨𝗦𝗧𝗥𝗜𝗘𝗦     ⛬",
    -- also ⛬
	opts = {
		position = "center",
		hl = "Special",
	}
}

-- https://lingojam.com/FancyTextGenerator
local hydraHelp = "<cmd>lua require('hydra').activate(require('monolith.plugins.hydra.manual').hydra())<cr>"
local fzfProjects = "<cmd>lua require('monolith.plugins.hydra.files').fzfProjects()<cr>"

-- --- @param sc string
-- --- @param txt string
-- --- @param keybind string? optional
-- --- @param keybind_opts table? optional
-- local function button(sc, txt, keybind, keybind_opts)
--     local sc_ = sc:gsub("%s", ""):gsub(vim.g.mapleader, "<leader>")
--
--     local opts = {
--         position = "center",
--         shortcut = "[" .. sc .. "] ",
--         cursor = 1,
--         width = 50,
--         align_shortcut = "left",
--         hl_shortcut = { { "Operator", 0, 1 }, { "Number", 1, #sc + 1 }, { "Operator", #sc + 1, #sc + 2 } },
--         shrink_margin = false,
--     }
--     if keybind then
--         keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
--         opts.keymap = { "n", sc_, keybind, keybind_opts }
--     end
--
--     local function on_press()
--         local key = vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true)
--         vim.api.nvim_feedkeys(key, "t", false)
--     end
--
--     return {
--         type = "button",
--         val = txt,
--         on_press = on_press,
--         opts = opts,
--     }
-- end
--- @param sc string
--- @param txt string
--- @param keybind string? optional
--- @param keybind_opts table? optional
local function button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub(vim.g.mapleader, "<leader>")

    local opts = {
        position = "center",
        shortcut = "",
        cursor = 1,
        width = 15,
        -- width = 46,
        align_shortcut = "left",
        hl_shortcut = "Comment",
        shrink_margin = false,
    }
    if keybind then
        keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { "n", sc_, keybind, keybind_opts }
    end

    local function on_press()
        local key = vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true)
        vim.api.nvim_feedkeys(key, "t", false)
    end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

local buttons = {
	type = "group",
	val = {
        -- button( "∖ff", "  > F I N D  F I L E" , "<cmd>FzfLua files<cr>"),
        -- button( "∖fr", "  > R E C E N T  F I L E S", "<cmd>FzfLua oldfiles<cr>"),
        -- button( "∖fp", "  > R E C E N T  P R O J E C T S"   , fzfProjects),
        -- button( "∖ce", "  > O P E N  C O N F I G", "<cmd>edit $MYVIMRC | tcd %:p:h<cr>"),
        -- button( "∖h ", "  > M A N U A L", hydraHelp),
        -- button( "e  ", "  > N E W  F I L E", "<cmd>enew<cr>"),
        -- button( "q  ", "  > E X I T", "<cmd>qa<cr>"),
        button( "∖fr", "> open oldfiles", "<cmd>FzfLua oldfiles<cr>"),
        button( "∖fp", "> open projects"   , fzfProjects),
        button( "∖ce", "> open config", "<cmd>edit $MYVIMRC | tcd %:p:h<cr>"),
        button( "∖h ", "> open manual", hydraHelp),
        button( "e  ", "> new file", "<cmd>enew<cr>"),
        button( "q  ", "> quit", "<cmd>qa<cr>"),
        -- dashboard.button( "∖ff", "  > ＦＩＮＤ ＦＩＬＥ" , "<cmd>FzfLua files<cr>"),
        -- dashboard.button( "∖fr", "  > ＲＥＣＥＮＴ ＦＩＬＥＳ", "<cmd>FzfLua oldfiles<cr>"),
        -- dashboard.button( "∖fp", "  > ＲＥＣＥＮＴ ＰＲＯＪＥＣＴＳ"   , "<cmd>Telescope projects<cr>"),
        -- dashboard.button( "∖fb", "  > ＦＩＬＥ ＢＲＯＷＳＥＲ" , "<cmd>Oil<cr>"),
        -- dashboard.button( "∖ce", "  > ＯＰＥＮ ＣＯＮＦＩＧ", "<cmd>edit $MYVIMRC | tcd %:p:h<cr>"),
        -- dashboard.button( "∖h ", "  > ＭＡＮＵＡＬ", hydraHelp),
        -- dashboard.button( "e  ", "  > ＮＥＷ ＦＩＬＥ", "<cmd>enew<cr>"),
        -- dashboard.button( "q  ", "  > ＥＸＩＴ", "<cmd>qa<cr>"),
	},
	opts = {
		spacing = 0,
		hl = "Text",
	},
}

local footer = {
	type = "text",
	val = "Today is" .. date,
	opts = {
		position = "center",
		hl = "Tag",
	}
}

-- local plugins_gen = io.popen('fd -d 2 . $HOME"/.local/share/nvim/site/pack/packer" | head -n -2 | wc -l | tr -d "\n" ')
-- local plugins = plugins_gen:read("*a")
-- plugins_gen:close()
local plugins = 0

if package.loaded["lazy"] then
    plugins = #(require("lazy").plugins())
end


local footer_2 = {
	type = "text",
	val = "Authority downloaded " .. plugins .. " entities to base reality",
	opts = {
		position = "center",
		hl = "Tag",
	},
}

local function get_time()
    local current_hour = tonumber(os.date("%H"))

    if current_hour < 5 then
        return "Good night"
    elseif current_hour < 12 then
        return "Good morning"
    elseif current_hour < 17 then
        return "Good afternoon"
    elseif current_hour < 20 then
        return "Good evening"
    else
        return "Good night"
    end
    -- if current_hour < 5 then
    --     return "    Good night!"
    -- elseif current_hour < 12 then
    --     return "  󰼰 Good morning!"
    -- elseif current_hour < 17 then
    --     return "    Good afternoon!"
    -- elseif current_hour < 20 then
    --     return "  󰖝  Good evening!"
    -- else
    --     return "  󰖔  Good night!"
    -- end
end

local footer_3 = {
	type = "text",
	val = get_time(),
	opts = {
		position = "center",
		hl = "Conditional",
	},
}

local section = {
	header = header,
	heading = heading,
	buttons = buttons,
	footer = footer,
	footer_2 = footer_2,
    footer_3 = footer_3,
}

local height = tonumber(vim.api.nvim_command_output("echo &lines")) or 0
-- local height = tonumber(vim.api.nvim_command_output("echo winheight('%')")) or 0

local function round(val)
    if val % 1 < 0.5 then return math.floor(val) end
    return math.ceil(val)
end

local opts = {
	layout = {
		{ type = "padding", val = round(height / 2 - 9) },
		-- { type = "padding", val = 1 },
		-- section.header,
		{ type = "padding", val = 1 },
		section.heading,
		{ type = "padding", val = 1 },
		section.buttons,
		{ type = "padding", val = 1 },
		-- section.footer_3,
  --       { type = "padding", val = 0 },
		-- section.footer,
		-- { type = "padding", val = 0 },
		section.footer_2,
	},
	opts = {
		margin = 44,
	},
}

alpha.setup(opts)
-- vim.cmd("Alpha")

-- function()
--   -- Get the current date and time
--
--   -- Get the current hour
--   local current_hour = tonumber(os.date("%H"))
--
--   -- Define the greeting variable
--   local greeting
--
--   if current_hour < 5 then
--     greeting = "    Good night!"
--   elseif current_hour < 12 then
--     greeting = "  󰼰 Good morning!"
--   elseif current_hour < 17 then
--     greeting = "    Good afternoon!"
--   elseif current_hour < 20 then
--     greeting = "  󰖝  Good evening!"
--   else
--     greeting = "  󰖔  Good night!"
--   end
--
--   dashboard.section.footer.val = greeting
--
--   pcall(vim.cmd.AlphaRedraw)
-- end

-- local logo = [[
--   ⠀⠀⣀⣀⡀⠀⠀⣀⣀⣀⣀⣀⣀⠀⠀⠀⣀⣀⣀⠀⠀⠀⠀⠀⣀⣀⠀⠀⠀⠀⣀⣀⡀⠀⢀⣀⡀⠀⢀⣀⣀⣀⣀⣀⡀⠀⠀
--   ⣴⣿⠟⠛⢿⣦⡀⣿⡟⠛⠛⠛⣿⣷⣰⣿⠟⠛⢿⣷⡄⢠⣠⣤⣿⠻⠗⠀⣴⣿⠟⠛⢿⣦⣸⣿⣧⣾⡿⢛⣿⡿⠟⠻⣿⣦⠀
--   ⣿⡇⠀⠀⠀⣿⡇⣿⣷⣄⡀⠀⠉⠁⣿⣇⠀⠀⠀⣿⡇⣀⡉⠻⢿⣶⣄⡰⣿⣇⠀⠀⠀⣿⡿⣿⣿⣅⡀⢸⣿⡀⠀⠀⢸⣿⠀
--   ⠙⠿⣷⣶⣦⣿⡇⠛⠋⠛⢿⣷⣤⡀⠙⠿⣷⣶⡦⣿⡇⢿⣷⣶⣶⣿⣿⣿⠙⠿⣷⣶⡆⣿⡟⠛⠋⠻⢿⣶⣿⣿⣷⣶⣼⣿
-- ]]

-- local header = {
-- 	type = "text",
-- 	val = {
-- 		"           ███████████████                 ▀▀▀▀▀▀▀▀██▀▀▀▀▀▀▀▀",
-- 		"           ███████████████                         ██        ",
-- 		"           ███████████████                 ██████████████████",
-- 		"           ███████████████                 ██              ██",
-- 		"           ███████████████                 ██████████████████",
-- 		"           ███████████████                     ██████████    ",
-- 		"           ███████████████                   ███▀  ██  ▀███  ",
-- 		"           ███████████████                 ███▀    ██    ▀███",
-- 		"           ███████████████                                   ",
-- 		"           ███████████████                 ██████████████████",
-- 		"           ███████████████                      ██    ██     ",
-- 		"           ███████████████                      ██    ██     ",
-- 		"           ██████████████████████████      ██▀▀▀▀▀▀▀▀▀▀▀▀▀▀██",
-- 		"           ██████████████████████████      ██              ██",
-- 		"           ██████████████████████████      ▀▀▀▀▀██▀▀▀▀██▀▀▀▀▀",
-- 		"           ██████████████████████████           ██    ██     ",
-- 		"           ██████████████████████████           ██    ██     ",
-- 		"           ██████████████████████████      ██████████████████",
-- 		"           ██████████████████████████                        ",
-- 		"           ██████████████████████████      ▀▀▀▀▀▀▀▀██▀▀▀▀▀▀▀▀",
-- 		"           ██████████████████████████      ▀▀▀▀▀▀▀▀██▀▀▀▀▀▀▀▀",
-- 		"           ██████████████████████████      ██████████████████",
-- 		"           ███████████████▀▀▀▀▀▀▀▀▀▀▀      ██              ██",
-- 		"           ███████████████                 ██████████████████",
-- 		"          ███████████████                 ▄▄▄▄▄▄▄▄██▄▄▄▄▄▄▄▄",
-- 		"         ████████████████                 ▄▄▄▄▄▄▄▄██▄▄▄▄▄▄▄▄",
-- 		"        █████████████████                                   ",
-- 		"       ██████████████████                 ██████████████████",
-- 		"      ███████████████████                         ██        ",
-- 		"     ████████████████████                         ██        ",
-- 		"    █████████████████████                         ██        ",
-- 		"   ██████████████████████                         ██        ",
-- 		"  ███████████████████████                         ██        ",
-- 		" ████████████████████████                         ██        ",
-- 		"█████████████████████████                 ██████████████████",
-- 	},
-- 	opts = {
-- 		position = "center",
-- 		hl = "Text",
-- 	}
-- }

        		-- "          █████████████                ▀▀▀▀▀▀██▀▀▀▀▀▀",
        		-- "          █████████████                      ██      ",
        		-- "          █████████████                ██▀▀▀▀▀▀▀▀▀▀██",
        		-- "          █████████████                ██▄▄▄▄▄▄▄▄▄▄██",
        		-- "          █████████████                  █ ██ █  ",
        		-- "          █████████████                 █  ██  █ ",
        		-- "          █████████████                              ",
        		-- "          █████████████                ▀▀▀██▀▀▀▀██▀▀▀",
        		-- "          █████████████                   ██    ██   ",
        		-- "          ██████████████████████       ██▀▀▀▀▀▀▀▀▀▀██",
        		-- "          ██████████████████████       ██▄▄▄▄▄▄▄▄▄▄██",
        		-- "          ██████████████████████          ██    ██   ",
        		-- "          ██████████████████████       ▄▄▄██▄▄▄▄██▄▄▄",
        		-- "          ██████████████████████                     ",
        		-- "          ██████████████████████       ▀▀▀▀▀▀██▀▀▀▀▀▀",
        		-- "          ██████████████████████       ▀▀▀▀▀▀██▀▀▀▀▀▀",
        		-- "          ██████████████████████       ██▀▀▀▀▀▀▀▀▀▀██",
        		-- "          █████████████                ██▄▄▄▄▄▄▄▄▄▄██",
        		-- "         █████████████                ▄▄▄▄▄▄██▄▄▄▄▄▄",
        		-- "        ██████████████                ▄▄▄▄▄▄██▄▄▄▄▄▄",
        		-- "       ███████████████                              ",
        		-- "      ████████████████                ▀▀▀▀▀▀██▀▀▀▀▀▀",
        		-- "     █████████████████                      ██      ",
        		-- "    ██████████████████                      ██      ",
        		-- "   ███████████████████                      ██      ",
        		-- "  ████████████████████                      ██      ",
        		-- " █████████████████████                      ██      ",
        		-- "██████████████████████                ▄▄▄▄▄▄██▄▄▄▄▄▄",

