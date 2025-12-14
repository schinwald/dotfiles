-- https://github.com/nvim-lualine/lualine.nvim
-- [[ Configure lualine.nvim ]] See `:help lualine.nvim`

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
	-- Unfortunately types don't exist D:
	config = function()
		-- TODO: figure out why I need to call setup explicitly
		local extensions = {
			-- Dap UI
			{
				name = "dapui_scopes",
				filetypes = { "dapui_scopes" },
				sections = {
					lualine_a = {
						function()
							return "Scopes"
						end,
					},
				},
			},
			{
				name = "dapui_breakpoints",
				filetypes = { "dapui_breakpoints" },
				sections = {
					lualine_a = {
						function()
							return "Breakpoints"
						end,
					},
				},
			},
			{
				name = "dapui_stacks",
				filetypes = { "dapui_stacks" },
				sections = {
					lualine_a = {
						function()
							return "Stacks"
						end,
					},
				},
			},
			{
				name = "dapui_watches",
				filetypes = { "dapui_watches" },
				sections = {
					lualine_a = {
						function()
							return "Watches"
						end,
					},
				},
			},
			{
				name = "dapui_console",
				filetypes = { "dapui_console" },
				sections = {
					lualine_a = {
						function()
							return "Console"
						end,
					},
				},
			},
			{
				name = "dap-repl",
				filetypes = { "dap-repl" },
				sections = {
					lualine_a = {
						function()
							return "REPL"
						end,
					},
				},
			},
			-- Diffview
			{
				name = "DiffviewFiles",
				filetypes = { "DiffviewFiles" },
				sections = {
					lualine_a = {
						function()
							return "Files"
						end,
					},
				},
			},
			-- Neotest
			{
				name = "neotest-summary",
				filetypes = { "neotest-summary" },
				sections = {
					lualine_a = {
						function()
							return "Tests"
						end,
					},
				},
			},
			{
				name = "neotest-output-panel",
				filetypes = { "neotest-output-panel" },
				sections = {
					lualine_a = {
						function()
							return "Debug Console"
						end,
					},
				},
			},
			-- Aerial
			{
				name = "aerial",
				filetypes = { "aerial" },
				sections = {
					lualine_a = {
						function()
							return "Outline"
						end,
					},
				},
			},
		}

		require("lualine").setup({
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			extensions = extensions,
		})
	end,
}
