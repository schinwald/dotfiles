-- TODO: configure this properly

return {
	"andymass/vim-matchup",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
	setup = function()
		vim.g.matchup_matchparen_offscreen = { method = "popup" }
	end,
}
