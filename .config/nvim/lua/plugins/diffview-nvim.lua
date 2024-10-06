return {
	"sindrets/diffview.nvim",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	keys = {
		{
			"<leader>dv",
			function()
				if vim.g.is_diffview_open then
					vim.api.nvim_command("DiffviewClose")
				else
					vim.api.nvim_command("DiffviewOpen")
				end
			end,
			desc = "Diffview Toggle",
		},
	},
	config = function(opts)
		local diffview = require("diffview")
		diffview.setup(opts)

		-- Override the default DiffviewOpen command with some additional logic
		vim.api.nvim_create_user_command("DiffviewOpen", function(opts)
			vim.fn.use_default_git()
			vim.g.is_diffview_open = true
			diffview.open({})
		end, { nargs = "?" })

		-- Override the default DiffviewClose command with some additional logic
		vim.api.nvim_create_user_command("DiffviewClose", function(opts)
			vim.g.is_diffview_open = false
			diffview.close()
		end, { nargs = "?" })
	end,
}
