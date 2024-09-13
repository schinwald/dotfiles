return {
	"folke/persistence.nvim",
	enable = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	event = "BufReadPre", -- this will only start session saving when an actual file was opened
	opts = {
		-- add any custom options here
	},
}
