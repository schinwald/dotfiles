local f = string.interpolate

-- Load theme
if not vim.g.vscode then
	vim.cmd.colorscheme("eldritch")
end

---@return table
local function interpolate_colors(label, source, destination, steps)
	local colors = {}
	f = string.interpolate

	local source_hex = string.to_hex(source)
	local destination_hex = string.to_hex(destination)

	local source_rgb = {
		red = bit.band(source_hex, 0xff0000),
		green = bit.band(source_hex, 0x00ff00),
		blue = bit.band(source_hex, 0x0000ff),
	}

	local destination_rgb = {
		red = bit.band(destination_hex, 0xff0000),
		green = bit.band(destination_hex, 0x00ff00),
		blue = bit.band(destination_hex, 0x0000ff),
	}

	for i = 1, steps + 1 do
		local t = i / (steps + 1)
		local interpolated_rgb = {
			red = bit.band(math.floor(source_rgb.red * (1 - t) + destination_rgb.red * t), 0xff0000),
			green = bit.band(math.floor(source_rgb.green * (1 - t) + destination_rgb.green * t), 0x00ff00),
			blue = bit.band(math.floor(source_rgb.blue * (1 - t) + destination_rgb.blue * t), 0x0000ff),
		}

		local new_color_hex = bit.bor(interpolated_rgb.red, interpolated_rgb.green, interpolated_rgb.blue)
		colors[f("{label}_{i * 50}")] = string.from_hex(new_color_hex)
	end

	return colors
end

-- Generate colors and their gradients
local function generate_colors()
	local theme = {
		gray = "#7081d0",
		bright_cyan = "#39ddfd",
		cyan = "#04d1f9",
		dark_cyan = "#10a1bd",
		magenta = "#a48cf2",
		pink = "#f265b5",
		purple = "#a48cf2",
		orange = "#f7c67f",
		yellow = "#f1fc79",
		blue = "#7081d0",
		dark_yellow = "#c0c95f",
		green = "#37f499",
		bright_green = "#00fa82",
		dark_green = "#33c57f",
		red = "#f16c75",
		bright_red = "#f0313e",
		white = "#ffffff",
	}

	local colors = {
		comment = "#7081d0",
		bg_dark = "#171928",
		bg = "#212337",
		bg_highlight = "#292e42",
		terminal_black = "#414868",
		fg = "#ebfafa",
		fg_dark = "#abb4da",
		fg_gutter = "#3b4261",
		fg_gutter_light = "#7081d0",
		gray_100 = "#2D334F",
		visual = "#76639e",
		bg_visual = "#76639e",
		magenta2 = "#bf4f8e",
		magenta3 = "#722f55",
	}

	for theme_key, theme_value in pairs(theme) do
		local gradient = interpolate_colors(theme_key, "#212337", theme_value, 17)
		for gradient_key, gradient_value in pairs(gradient) do
			colors[gradient_key] = gradient_value
		end
	end

	return colors
end

local colors = generate_colors()

-- Custom colors
vim.cmd(f("highlight Normal guibg=none"))
vim.cmd(f("highlight NonText guibg=none"))
vim.cmd(f("highlight SignColumn guibg=none"))
vim.cmd(f("highlight VertSplit guibg=none"))
vim.cmd(f("highlight StatusLine guibg=none"))
vim.cmd(f("highlight StatusLineNC guibg=none"))
vim.cmd(f("highlight Folded guibg={colors.white_50} guifg={colors.white_600}"))

-- TODO: fix this
vim.cmd(f("highlight Float ctermbg=none"))
vim.cmd(f("highlight FloatBorder ctermbg=none"))
vim.cmd(f("highlight TelescopeNormal ctermbg=none"))
vim.cmd(f("highlight TelescopeBorder ctermbg=none"))
vim.cmd(f("highlight TelescopeTitle ctermbg=none"))
vim.cmd(f("highlight TelescopePromptNormal ctermbg=none"))
vim.cmd(f("highlight TelescopePromptBorder ctermbg=none"))
vim.cmd(f("highlight TelescopeResultsNormal ctermbg=none"))
vim.cmd(f("highlight TelescopeResultsBorder ctermbg=none"))

-- Diff colors
vim.cmd(f("highlight DiffDeleteOurs guifg={colors.gray_100} guibg=none"))
vim.cmd(f("highlight DiffDeleteTheirs guifg={colors.gray_100} guibg=none"))
vim.cmd(f("highlight DiffDelete guifg=none guibg={colors.red_100}"))

vim.cmd(f("highlight DiffAddOurs guifg=none guibg={colors.red_100}"))
vim.cmd(f("highlight DiffAddTheirs guifg=none guibg={colors.green_100}"))
vim.cmd(f("highlight DiffAdd guifg=none guibg={colors.green_100}"))

vim.cmd(f("highlight DiffChangeOurs guifg=none guibg={colors.red_100}"))
vim.cmd(f("highlight DiffChangeTheirs guifg=none guibg={colors.green_100}"))
vim.cmd(f("highlight DiffChange guibg={colors.blue_100}"))

vim.cmd(f("highlight DiffTextOurs guibg={colors.red_300} guifg=none"))
vim.cmd(f("highlight DiffTextTheirs guibg={colors.green_300} guifg=none"))
vim.cmd(f("highlight DiffText guibg={colors.blue_300} guifg=none"))

-- Diffview fix linking
vim.cmd(f("highlight! link DiffviewDiffText DiffText"))
