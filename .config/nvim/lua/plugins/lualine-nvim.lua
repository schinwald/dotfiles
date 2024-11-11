-- https://github.com/nvim-lualine/lualine.nvim
-- [[ Configure lualine.nvim ]] See `:help lualine.nvim`

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
	-- Unfortunately types don't exist D:
	config = function(opt)
		-- TODO: figure out why I need to call setup explicitly
		require("lualine").setup(opt)
	end,
}
