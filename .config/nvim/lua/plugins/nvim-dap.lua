return {
	"mfussenegger/nvim-dap",
	lazy = true,
	config = function()
		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "", texthl = "DapBreakpointText", linehl = "DapBreakpointLine", numhl = "DapBreakpointNum" }
		)
		vim.fn.sign_define(
			"DapStopped",
			{ text = "", texthl = "DapStoppedText", linehl = "DapStoppedLine", numhl = "DapStoppedNum" }
		)
	end,
	-- Copied from LazyVim/lua/lazyvim/plugins/extras/dap/core.lua and
	-- modified.
	keys = {
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint",
		},

		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Continue",
		},

		{
			"<leader>dC",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Run to Cursor",
		},

		{
			"<leader>dT",
			function()
				require("dap").terminate()
			end,
			desc = "Terminate",
		},
	},
}
