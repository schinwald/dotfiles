-- https://github.com/numToStr/Comment.nvim
-- [[ Configure Comment ]] See `:help Comment`

return {
	"numToStr/Comment.nvim",
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
	---@type CommentConfig | {}
	opts = {},
}
