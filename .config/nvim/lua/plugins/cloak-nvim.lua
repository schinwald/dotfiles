return {
	"laytan/cloak.nvim",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
}
