-- https://github.com/nvim-treesitter/nvim-treesitter
-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	---@type TSConfig
	---@diagnostic disable: missing-fields
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
			"latex",
			"norg",
			"scss",
			"svelte",
			"typst",
			"vue",
		},
		-- Autoinstall languages that are not installed
		auto_install = true,
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
	},
	---@param opts TSConfig
	config = function(_, opts)
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter").setup(opts)
	end,
}
