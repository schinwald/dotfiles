return {
	"jay-babu/mason-nvim-dap.nvim",
	dependencies = {
		"mfussenegger/nvim-dap",
		"williamboman/mason.nvim",
	},
	---@type MasonNvimDapSettings
	opts = {
		handlers = {},
		automatic_installation = {
			exclude = {
				"delve",
				"python",
			},
		},
	},
	config = function(opts)
		require("mason-nvim-dap").setup(opts)

		-- Unfortunately, js-debug-adapter isn't registered automatically so we need to do it manually
		local register_js_debug_adapter = function()
			require("dap").adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}

			require("dap").adapters["pwa-chrome"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}
		end

		register_js_debug_adapter()
	end,
}
