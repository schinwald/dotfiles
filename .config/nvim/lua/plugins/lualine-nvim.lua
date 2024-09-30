return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	opt = {},
	config = function(opt)
		-- TODO: figure out why I need to call setup explicitly
		require("lualine").setup(opt)
	end,
}
