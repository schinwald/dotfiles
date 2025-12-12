return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	build = ":Copilot auth",
	event = "BufReadPost",
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
