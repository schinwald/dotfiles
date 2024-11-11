-- https://github.com/folke/which-key.nvim
-- [[ Configure WhichKey ]] See `:help which-key`

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
	---@type wk.Opts
	opts = {},
  -- stylua: ignore
	keys = {
		{
      mode = { "n" },
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (WhichKey)",
		},
	},
}
