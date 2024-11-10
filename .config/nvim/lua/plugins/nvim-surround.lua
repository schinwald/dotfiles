return {
	"kylechui/nvim-surround",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({
			-- Configuration here, or leave empty to use defaults
			keymaps = {
				insert = "<C-g>s",
				insert_line = "<C-g>S",
				normal = "ys",
				normal_cur = "yss",
				normal_line = "yS",
				normal_cur_line = "ySS",
				visual = "gs",
				visual_line = "gS",
				delete = "ds",
				change = "cs",
				change_line = "cS",
			},
		})
	end,
}
