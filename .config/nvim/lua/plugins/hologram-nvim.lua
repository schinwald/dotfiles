return {
	"edluffy/hologram.nvim",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	config = function()
		require("hologram").setup({
			auto_display = true, -- WIP automatic markdown image display, may be prone to breaking
		})
	end,
}
