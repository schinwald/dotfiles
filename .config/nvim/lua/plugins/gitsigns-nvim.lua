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
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			map("n", "<leader>ghp", gitsigns.preview_hunk_inline, { desc = "[H]unk [P]review" })
			map("n", "<leader>ghr", gitsigns.reset_hunk, { desc = "[H]unk [R]eset" })
			map("n", "<leader>gB", gitsigns.blame, { desc = "[G]it [B]lame" })
		end,
	},
}
