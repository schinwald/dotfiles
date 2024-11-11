-- https://github.com/RRethy/vim-illuminate
-- [[ Configure Illuminate ]] See `:help illuminate`

return {
	"RRethy/vim-illuminate",
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
}
