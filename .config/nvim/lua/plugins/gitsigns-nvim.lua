-- https://github.com/lewis6991/gitsigns.nvim
-- [[ Configure Gitsigns ]] See `:help gitsigns`

return {
	"lewis6991/gitsigns.nvim",
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
	---@type Gitsigns.Config
	---@diagnostic disable: missing-fields
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

			-- TODO: move keys to root of this config (must still follow on_attach)
			map("n", "<leader>ghp", gitsigns.preview_hunk_inline, { desc = "[H]unk [P]review" })
			map("n", "<leader>ghr", gitsigns.reset_hunk, { desc = "[H]unk [R]eset" })
			map("n", "<leader>ghs", gitsigns.stage_hunk, { desc = "[H]unk [S]tage/Unstage" })
			map("n", "<leader>gB", gitsigns.blame, { desc = "[G]it [B]lame" })
		end,
	},
	setup = function()
		require("gitsigns").setup()
	end,
}
