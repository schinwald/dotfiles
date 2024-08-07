return {
	"sindrets/diffview.nvim",
	keys = {
		{
			"<leader>dv",
			function()
				local diffview = require("diffview")

				vim.fn.use_default_git()

				if vim.g.is_diffview_open then
					diffview.close()
				else
					-- TODO: add opts back into this
					diffview.open()
				end

				vim.g.is_diffview_open = not vim.g.is_diffview_open
			end,
			desc = "Diffview Toggle",
		},
	},
}
