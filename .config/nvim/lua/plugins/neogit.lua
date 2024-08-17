return {
	"NeogitOrg/neogit",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	config = true,
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		-- Only one of these is needed, not both.
		"nvim-telescope/telescope.nvim", -- optional
		"ibhagwan/fzf-lua", -- optional
	},
}
