-- TODO: configure this properly

return {
	"RRethy/vim-illuminate",
	enabled = function()
		if vim.g.vscode then
			return false
		end

		return true
	end,
}
