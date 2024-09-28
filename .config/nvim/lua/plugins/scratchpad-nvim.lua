return {
	"LintaoAmons/scratch.nvim",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	event = "VeryLazy",
}
