return {
	"Wansmer/treesj",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	keys = { "<space>m", "<space>j", "<space>s" },
	dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
	config = function()
		require("treesj").setup()
	end,
}
