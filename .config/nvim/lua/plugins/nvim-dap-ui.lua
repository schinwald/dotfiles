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
		"jay-babu/mason-nvim-dap.nvim",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
	},
}
