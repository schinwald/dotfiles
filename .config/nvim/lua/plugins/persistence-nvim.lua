-- https://github.com/folke/persistence.nvim
-- [[ Configure Persistence ]] See `:help persistence`

-- TODO: write an autocmd to load the session on startup (maybe with dashboard.nvim?)

return {
	"folke/persistence.nvim",
	event = "BufReadPre", -- this will only start session saving when an actual file was opened
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
	---@type Persistence.Config
	opts = {},
}
