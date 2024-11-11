-- https://github.com/nvimdev/dashboard-nvim
-- [[ Configure Dashboard ]] See `:help dashboard-nvim`

return {
	"nvimdev/dashboard-nvim",
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	event = "VimEnter",
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
	config = function()
		require("dashboard").setup()
	end,
}
