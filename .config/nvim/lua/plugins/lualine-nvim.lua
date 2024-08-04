return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opt = {},
	config = function(opt)
		-- TODO: figure out why I need to call setup explicitly
		require("lualine").setup(opt)
	end,
}
