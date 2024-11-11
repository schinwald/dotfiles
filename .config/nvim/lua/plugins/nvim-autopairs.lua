-- https://github.com/windwp/nvim-autopairs
-- [[ Configure nvim-autopairs ]] See `:help nvim-autopairs`

return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
	config = true,
	-- use opts = {} for passing setup options
	-- this is equivalent to setup({}) function
	-- TODO: how does this work?
}
