return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	config = true,
	-- use opts = {} for passing setup options
	-- this is equivalent to setup({}) function
}
