return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- Adapaters
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-jest",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python")({}),
				require("neotest-jest")({
					jestCommand = function()
						return vim.g.neotest_command
					end,
				}),
			},
			icons = {
				child_indent = "│",
				child_prefix = "├",
				collapsed = "─",
				expanded = "╮",
				failed = "",
				final_child_indent = " ",
				final_child_prefix = "╰",
				non_collapsible = "─",
				notify = "",
				passed = "",
				running = "",
				running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
				skipped = "",
				test = "",
				unknown = "",
				watching = "",
			},
		})
	end,
}
