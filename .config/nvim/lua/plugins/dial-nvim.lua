-- https://github.com/monaqa/dial.nvim
-- [[ Configure Dial ]] See `:help dial.nvim`

return {
	"monaqa/dial.nvim",
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
}
