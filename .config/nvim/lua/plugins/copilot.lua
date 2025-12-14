return {
	"zbirenbaum/copilot.lua",
	build = ":Copilot auth",
	event = "BufReadPost",
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		---@diagnostic disable: undefined-field
		if vim.g.autocomplete_engine ~= "copilot" then
			return false
		end

		return true
	end,
	opts = {
		suggestion = {
			auto_trigger = true,
			keymap = {
				-- TODO: consider using blink or nvm-cmp for this?
				accept = "<C-S-y>",
			},
		},
		copilot_node_command = { "mise", "exec", "node@latest", "--", "node" },
		panel = {
			enabled = false,
		},
	},
}
