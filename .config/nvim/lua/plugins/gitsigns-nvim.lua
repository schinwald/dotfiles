return {
	"lewis6991/gitsigns.nvim",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	config = true,
}
