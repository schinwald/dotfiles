-- https://github.com/folke/trouble.nvim
-- [[ Configure Trouble ]] See `:help trouble`

return {
	"folke/trouble.nvim",
	cmd = "Trouble",
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
			"<leader>qd",
			"<cmd>Trouble diagnostics toggle focus=true<cr>",
			desc = "[Q]uickfix [D]iagnostics (Trouble)",
		},
	},
	---@type trouble.Config
	opts = {},
}
