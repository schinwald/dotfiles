-- https://github.com/stevearc/oil.nvim
-- [[ Configure Oil ]] See `:help oil`

return {
	"stevearc/oil.nvim",
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	event = "VimEnter",
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
  -- stylua: ignore
	keys = {
		{
			mode = { "n" },
			"-",
			function()
				require("oil").open()
			end,
			{ desc = "Open parent directory" },
		},
	},
	---@type oil.Config
	---@diagnostic disable: missing-fields
	opts = {
		default_file_explorer = true,
		view_options = {
			show_hidden = true,
		},
	},
}
