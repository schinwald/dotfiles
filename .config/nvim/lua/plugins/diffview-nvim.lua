-- https://github.com/sindrets/diffview.nvim
-- [[ Configure Diffview ]] See `:help diffview.nvim`

return {
	"sindrets/diffview.nvim",
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
  -- stylua: ignore
	keys = {
		{
			mode = "n",
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
		{
			mode = "n",
			"<leader>dfh",
			function()
        vim.api.nvim_command("DiffviewFileHistory %")
			end,
			desc = "Diffview File History",
		},
	},
	---@param opts DiffviewConfig
	config = function(opts)
		local diffview = require("diffview")
		diffview.setup(opts)

		-- Override the default DiffviewOpen command with some additional logic
		vim.api.nvim_create_user_command("DiffviewOpen", function()
			vim.g["is_diffview_open"] = true
			diffview.open({})
		end, { nargs = "?" })

		-- Override the default DiffviewClose command with some additional logic
		vim.api.nvim_create_user_command("DiffviewClose", function()
			vim.g["is_diffview_open"] = false
			diffview.close()
		end, { nargs = "?" })
	end,
}
