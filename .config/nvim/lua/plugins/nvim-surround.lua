-- https://github.com/kylechui/nvim-surround
-- [[ Configure nvim-surround ]] See `:help nvim-surround`

return {
	"kylechui/nvim-surround",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
	keys = {
		-- Insert mode
		{ "<C-g>s", "<Plug>(nvim-surround-insert)", mode = "i" },
		{ "<C-g>S", "<Plug>(nvim-surround-insert-line)", mode = "i" },

		-- Normal mode
		{ "ys", "<Plug>(nvim-surround-normal)", mode = "n" },
		{ "yss", "<Plug>(nvim-surround-normal-cur)", mode = "n" },
		{ "yS", "<Plug>(nvim-surround-normal-line)", mode = "n" },
		{ "ySS", "<Plug>(nvim-surround-normal-cur-line)", mode = "n" },

		-- Visual mode
		{ "gs", "<Plug>(nvim-surround-visual)", mode = "x" },
		{ "gS", "<Plug>(nvim-surround-visual-line)", mode = "x" },

		-- Delete
		{ "ds", "<Plug>(nvim-surround-delete)", mode = "n" },

		-- Change
		{ "cs", "<Plug>(nvim-surround-change)", mode = "n" },
		{ "cS", "<Plug>(nvim-surround-change-line)", mode = "n" },
	},
	config = function()
		require("nvim-surround").setup()
	end,
}
