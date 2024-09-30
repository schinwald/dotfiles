return {
	"ThePrimeagen/harpoon",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	dependencies = { "nvim-lua/plenary.nvim" },
}
