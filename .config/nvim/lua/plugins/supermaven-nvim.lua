return {
	"supermaven-inc/supermaven-nvim",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<C-S-y>",
			},
			ignore_filetypes = { cpp = true },
			color = {
				-- TODO: update colors to be more subtle
				-- suggestion_color = "#ffffff",
				-- cterm = 244,
			},
			log_level = "off",
			disable_inline_completion = false,
			disable_keymaps = false,
			-- Condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
			condition = function()
				return false
			end,
		})
	end,
}
