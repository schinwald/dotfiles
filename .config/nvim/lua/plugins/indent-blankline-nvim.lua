-- https://github.com/lukas-reineke/indent-blankline.nvim
-- [[ Configure indent-blankline.nvim ]] See `:help indent-blankline.nvim`

return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
	---@type ibl.config
	opts = {
		exclude = {
			filetypes = {
				"lspinfo",
				"packer",
				"checkhealth",
				"help",
				"man",
				"gitcommit",
				"TelescopePrompt",
				"TelescopeResults",
				"dashboard",
			},
		},
	},
}
