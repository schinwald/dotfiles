-- https://github.com/almo7aya/openingh.nvim
-- [[ Configure Open In GitHub ]] See `:help openingh`

return {
	"almo7aya/openingh.nvim",
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
      mode = { "n" },
			"<leader>br",
			"<cmd>OpenInGHRepo<cr>",
			desc = "[B]rowse [r]epository",
		},
		{
      mode = { "n" },
			"<leader>bl",
			"<cmd>OpenInGHFileLines<cr>",
			desc = "[B]rowse repository on file [l]ine",
		},
	},
}
