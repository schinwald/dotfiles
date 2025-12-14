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
		local dap = require("dap")

		-- Unfortunately, js-debug-adapter isn't registered automatically so we need to do it manually
		local register_js_debug_adapter = function()
			local command = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug-adapter"
			local stat = vim.loop.fs_stat(command)

			if not stat then
				vim.notify("js-debug-adapter: command not found under " .. command, vim.log.levels.ERROR)
				return
			end

			local adapter = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = command,
					args = { "${port}" },
				},
			}

			dap.adapters["pwa-node"] = adapter
			dap.adapters["pwa-chrome"] = adapter
		end

		register_js_debug_adapter()

		-- Configure launch configurations for TypeScript/Node.js
		-- These configurations enable proper source map resolution for breakpoints
		dap.configurations.typescript = {
			{
				type = "pwa-node",
				request = "attach",
				name = "Attach to Running Server (Port 9229)",
				port = 9229,
				cwd = "${workspaceFolder}",
				sourceMaps = true,
				skipFiles = { "<node_internals>/**", "node_modules/**" },
				resolveSourceMapLocations = {
					"${workspaceFolder}/**",
					"!**/node_modules/**",
				},
			},
			{
				type = "pwa-chrome",
				request = "launch",
				name = "Launch Chrome",
				url = "http://localhost:5601",
				webRoot = "${workspaceFolder}",
				sourceMaps = true,
				skipFiles = { "<node_internals>/**", "node_modules/**" },
				resolveSourceMapLocations = {
					"${workspaceFolder}/**",
					"!**/node_modules/**",
				},
			},
		}

		-- Copy configurations to javascript as well
		dap.configurations.javascript = dap.configurations.typescript
		dap.configurations.javascriptreact = dap.configurations.typescript
		dap.configurations.typescriptreact = dap.configurations.typescript
	end,
}
