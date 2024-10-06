return {
	"lewis6991/gitsigns.nvim",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	opts = {
		worktrees = {
			{
				toplevel = vim.env.GIT_WORK_TREE,
				gitdir = vim.env.GIT_DIR,
			},
		},
	},
}
