return {
	"NeogitOrg/neogit",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	lazy = false,
	keys = {
		{
			"<leader>gs",
			function()
				require("neogit").open()
			end,
			{ desc = "[G]it [S]tatus" },
		},
		{
			"<leader>gc",
			":Neogit commit<CR>",
			{ desc = "[G]it [C]ommit" },
		},
		{
			"<leader>gp",
			":Neogit pull<CR>",
			{ desc = "[G]it [P]ull" },
		},
		{
			"<leader>gP",
			":Neogit push<CR>",
			{ desc = "[G]it [P]ush" },
		},
		{
			"<leader>gb",
			":Telescope git_branches<CR>",
			{ desc = "Switch [G]it [B]ranch" },
		},
		{
			"<leader>gB",
			":G blame<CR>",
			{ desc = "Toggle [G]it [B]lame" },
		},
	},
	config = true,
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		-- Only one of these is needed, not both.
		"nvim-telescope/telescope.nvim", -- optional
		"ibhagwan/fzf-lua", -- optional
	},
}
