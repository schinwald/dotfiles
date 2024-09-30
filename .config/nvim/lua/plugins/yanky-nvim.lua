return {
	"gbprod/yanky.nvim",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
}
