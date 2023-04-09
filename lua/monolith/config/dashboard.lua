local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")

-- db.custom_header = {
--     '',
--     '░█▄░█▒██▀░▄▀▄░█▒█░█░█▄▒▄█',
--     '░█▒▀█░█▄▄░▀▄▀░▀▄▀░█░█▒▀▒█',
--     '',
-- }

local header = {
	type = "text",
	val = {
        '',
        '',
        '',
        ' ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓',
        ' ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒',
        '▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░',
        '▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ ',
        '▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒',
        '░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░',
        '░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░',
        '   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   ',
        '         ░    ░  ░    ░ ░        ░   ░         ░   ',
        '                                ░                  ',
        '',
	},
	opts = {
		position = "center",
		hl = "Text",
	}
}
-- 東亜重工
-- 統和機構
-- 

local splitter = {
	type = "text",
	val = "",
	opts = {
		position = "center",
		hl = "Conditional",
	}
}

-- https://lingojam.com/FancyTextGenerator

local buttons = {
	type = "group",
	val = {
        dashboard.button( "∖ff", "  > Find File" , "<cmd>Telescope find_files<cr>"),
        dashboard.button( "∖fr", "  > Recent files", "<cmd>Telescope oldfiles<cr>"),
        dashboard.button( "∖fp", "  > Recent projects"   , "<cmd>Telescope projects<cr>"),
        dashboard.button( "∖fb", "  > File Browser" , "<cmd>Telescope file_browser<cr>"),
        dashboard.button( "∖ce", "  > Open config", "<cmd>tabnew $MYVIMRC | tcd %:p:h<cr>"),
        dashboard.button( "∖h", "  > Manual", "\\h"),
        dashboard.button( "e", "  > New file", "<cmd>enew<cr>"),
        dashboard.button( "q", "  > Exit", "<cmd>qa<cr>"),
	},
	opts = {
		spacing = 1,
		hl = "Text"
	},
}


local footers = {
    'ᕙ(⇀‸↼‶)ᕗ',
    '┻━┻︵ \\(°□°)/ ︵ ┻━┻ ',
    '(╯°□°）╯︵ ┻━┻',
    '(⋟﹏⋞) ',
    'c[_]',
    '(ﾉ◕ヮ◕)ﾉ*:･ﾟ✧',
    '=^..^=',
    '┏━┓ ︵ /(^.^/)',
    'ᗧ···ᗣ···ᗣ··',
    '[●▪▪●]',
    'ヽ(￣(ｴ)￣)ﾉ',
    '~(‾▿‾)~',
    '(╭ರ_•́)',
    '┬┴┬┴┤･ω･)ﾉ├┬┴┬┴',
    'ᕕ( ᐛ )ᕗ',
    '║▌║█║▌│║▌║▌█',
    '(╯°_°）╯︵ ━━━',
    'd[-_-]b',
    'ヾ(_ _。）',
    ': ◉ ∧ ◉ :',
    '(ヘ･_･)ヘ┳━┳',
    '~(^._.)',
    'mmmyyyyy<⦿⽘⦿>aaaaannn',
    '0% [░░░░░▒▒▒▒▒▓▓▓▓▓█████] 100%',
    'ヽ（´ー｀）┌',
    -- '',
}

local function genfooter()
    local date = os.date("  %d/%m/%Y ")
    local time = os.date("  %H:%M:%S ")

    local plugins_gen = io.popen('fd -d 2 . $HOME"/.local/share/nvim/site/pack/packer" | head -n -2 | wc -l | tr -d "\n" ')
    local plugins = plugins_gen:read("*a")
    plugins_gen:close()
    
  
    local v = vim.version()
    local version = "  v" .. v.major .. "." .. v.minor .. "." .. v.patch
  
    -- return date .. time .. version
    plugins = "  " .. plugins .. " plugins "
    return date .. time .. plugins .. version
end

math.randomseed( os.time() )


local footer = {
	type = "text",
	val = genfooter(),
	opts = {
		position = "center",
		hl = "Conditional",
	}
}

local footer_2 = {
	type = "text",
	val = footers[ math.random( #footers )  ],
	opts = {
		position = "center",
		hl = "Conditional",
	},
}


local section = {
	header = header,
	splitter = splitter,
	buttons = buttons,
	footer = footer,
	footer_2 = footer_2,
}

local opts = {
	layout = {
		{ type = "padding", val = 1 },
		section.header,
		{ type = "padding", val = 1 },
		section.splitter,
		{ type = "padding", val = 1 },
		section.buttons,
		{ type = "padding", val = 1 },
		section.footer,
		{ type = "padding", val = 1 },
		section.footer_2
	},
	opts = {
		margin = 44,
	},
}

alpha.setup(opts)

-- Disable folding on alpha buffer
vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])