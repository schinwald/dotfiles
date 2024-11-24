-- https://github.com/laytan/cloak.nvim
-- [[ Configure Cloak ]] See `:help cloak.nvim`

return {
	"laytan/cloak.nvim",
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
	keys = {
		{
			mode = { "n" },
			"<leader>cp",
			"<cmd>CloakPreviewLine<cr>",
			desc = "[C]loak [P]review",
		},
	},
	-- Unfortunately types don't exist D:
	opts = {},
}
