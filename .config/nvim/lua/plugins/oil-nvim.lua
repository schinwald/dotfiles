return {
	"stevearc/oil.nvim",
	event = "VimEnter",
	keys = {
		{
			"-",
			mode = { "n" },
			function()
				require("oil").open()
			end,
			{ desc = "Open parent directory" },
		},
	},
	opts = {
		default_file_explorer = true,
		view_options = {
			show_hidden = true,
		},
	},
	-- Optional dependencies
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
}
