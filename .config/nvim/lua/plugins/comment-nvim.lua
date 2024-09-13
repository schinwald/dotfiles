return {
	"numToStr/Comment.nvim",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	opts = {
		-- add any options here
	},
}
