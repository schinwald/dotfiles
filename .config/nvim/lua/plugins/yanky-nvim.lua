-- https://github.com/gbprod/yanky.nvim
-- [[ Configure Yanky ]] See `:help yanky`

return {
	"gbprod/yanky.nvim",
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
	-- Unfortunately types don't exist D:
	opts = {},
}
