-- https://github.com/NeogitOrg/neogit
-- [[ Configure Neogit ]] See `:help neogit`

return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
		"nvim-telescope/telescope.nvim", -- optional
	},
	lazy = false,
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
  -- stylua: ignore
	keys = {
		{
      mode = { "n" },
			"<leader>gs",
			function()
				require("neogit").open()
			end,
			{ desc = "[G]it [S]tatus" },
		},
		{
      mode = { "n" },
			"<leader>gc",
			":Neogit commit<CR>",
			{ desc = "[G]it [C]ommit" },
		},
		{
      mode = { "n" },
			"<leader>gp",
			":Neogit pull<CR>",
			{ desc = "[G]it [P]ull" },
		},
		{
      mode = { "n" },
			"<leader>gP",
			":Neogit push<CR>",
			{ desc = "[G]it [P]ush" },
		},
		{
      mode = { "n" },
			"<leader>gb",
			":Telescope git_branches<CR>",
			{ desc = "Switch [G]it [B]ranch" },
		},
	},
	-- TODO: do I need this?
	config = true,
}
