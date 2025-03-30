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
	keys = {
		{
			"m1",
			function()
				require("harpoon.ui").nav_file(1)
			end,
			desc = "Harpoon: Navigate to File 1",
		},
		{
			"m2",
			function()
				require("harpoon.ui").nav_file(2)
			end,
			desc = "Harpoon: Navigate to File 2",
		},
		{
			"m3",
			function()
				require("harpoon.ui").nav_file(3)
			end,
			desc = "Harpoon: Navigate to File 3",
		},
		{
			"m4",
			function()
				require("harpoon.ui").nav_file(4)
			end,
			desc = "Harpoon: Navigate to File 4",
		},
		{
			"m5",
			function()
				require("harpoon.ui").nav_file(5)
			end,
			desc = "Harpoon: Navigate to File 5",
		},
		{
			"ml",
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			desc = "Harpoon: Toggle Quick Menu",
		},
		{
			"mm",
			function()
				require("harpoon.mark").add_file()
			end,
			desc = "Harpoon: Add File to Marks",
		},
	},
}
