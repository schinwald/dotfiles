-- https://github.com/alexghergh/nvim-tmux-navigation
-- [[ Configure Nvim Tmux Navigation ]] See `:help nvim-tmux-navigation`

return {
	"alexghergh/nvim-tmux-navigation",
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
	config = function()
		local nvim_tmux_nav = require("nvim-tmux-navigation")

		vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
		vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
		vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
		vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
	end,
}
