-- https://github.com/andymass/vim-matchup
-- [[ Configure Matchup ]] See `:help matchup`

return {
	"andymass/vim-matchup",
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
	setup = function()
		vim.g.matchup_matchparen_offscreen = { method = "popup" }
	end,
}
