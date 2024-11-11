-- https://github.com/Wansmer/treesj
-- [[ Configure Treesitter Join ]] See `:help treesj`

return {
	"Wansmer/treesj",
	dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
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
			"<space>o",
			"<cmd>TSJToggle<cr>",
			{ desc = "Treesitter Toggle [O]pen" },
		},
	},
	config = function()
		require("treesj").setup()
	end,
}
