-- https://github.com/sindrets/diffview.nvim
-- [[ Configure Diffview ]] See `:help diffview.nvim`

return {
	"sindrets/diffview.nvim",
	dependencies = {
		"folke/snacks.nvim",
	},
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
        if require("diffview.lib").get_current_view() then
          vim.notify("Already in diff view", vim.log.levels.ERROR)
        else
          vim.api.nvim_command("DiffviewOpen")
        end
			end,
			desc = "[D]iff[v]iew Open",
		},
		{
			mode = "n",
			"<leader>gfh",
			function()
        if require("diffview.lib").get_current_view() then
          vim.notify("Already in file history", vim.log.levels.ERROR)
        else
          vim.api.nvim_command("DiffviewFileHistory %")
        end
			end,
			desc = "[G]it [F]ile [H]istory",
		},
		{
			mode = "n",
			"<leader>dc",
			function()
        if require("diffview.lib").get_current_view() then
          vim.api.nvim_command("DiffviewClose")
        else
          vim.notify("No diff view is open", vim.log.levels.ERROR)
        end
			end,
			desc = "[D]iffview [C]lose",
		},
	},
	---@diagnostic disable: missing-fields
	---@type DiffviewConfig
	opts = {
		view = {
			default = {
				layout = "diff2_horizontal",
			},
			merge_tool = {
				layout = "diff1_plain",
			},
		},
		hooks = {
			diff_buf_win_enter = function(bufnr, winid, ctx)
				if ctx.layout_name:match("^diff2") then
					if ctx.symbol == "a" then
						vim.opt_local.winhl = table.concat({
							"DiffDelete:DiffDeleteOurs",
							"DiffAdd:DiffAddOurs",
							"DiffChange:DiffChangeOurs",
							"DiffText:DiffTextOurs",
						}, ",")
					elseif ctx.symbol == "b" then
						vim.opt_local.winhl = table.concat({
							"DiffDelete:DiffDeleteTheirs",
							"DiffAdd:DiffAddTheirs",
							"DiffChange:DiffChangeTheirs",
							"DiffText:DiffTextTheirs",
						}, ",")
					end
				end

				-- Hide underline on cursorline
				-- https://github.com/neovim/neovim/issues/9800
				vim.wo[winid].culopt = "number"
			end,
		},
	},
	config = true,
}
