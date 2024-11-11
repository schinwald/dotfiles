-- https://github.com/ThePrimeagen/harpoon
-- [[ Configure Harpoon ]] See `:help harpoon`

return {
	"ThePrimeagen/harpoon",
	dependencies = { "nvim-lua/plenary.nvim" },
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
}
