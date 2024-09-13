return {
	"LintaoAmons/scratch.nvim",
	enable = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	event = "VeryLazy",
}
