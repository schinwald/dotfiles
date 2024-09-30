return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
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
