return {
	"rcarriga/nvim-dap-ui",
	config = true,
	keys = {
		{
			"<leader>du",
			function()
				require("dapui").toggle({})
			end,
			desc = "[D]ap [U]I",
		},
	},
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		"jay-babu/mason-nvim-dap.nvim",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		require("dapui").setup({
			element_mappings = {
				stacks = {
					open = "<CR>",
					expand = "o",
				},
			},
		})
	end,
}
