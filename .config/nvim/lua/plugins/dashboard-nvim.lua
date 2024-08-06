return {
	"nvimdev/dashboard-nvim",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return false
	end,
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			-- config
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
