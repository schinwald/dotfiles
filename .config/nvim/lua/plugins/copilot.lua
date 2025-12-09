return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	build = ":Copilot auth",
	event = "BufReadPost",
	opts = {
		suggestion = {
			auto_trigger = true,
			keymap = {
				accept = false, -- handled by nvim-cmp / blink.cmp
				next = "<M-]>",
				prev = "<M-[>",
			},
		},
		copilot_node_command = { "mise", "exec", "node@latest", "--", "node" },
		panel = {
			enabled = false,
		},
	},
}
