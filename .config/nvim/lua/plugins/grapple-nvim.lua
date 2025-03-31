-- https://github.com/cbochs/grapple.nvim
-- [[ Configure Grapple ]] ??

return {
	"cbochs/grapple.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", lazy = true },
	},
	opts = {
		scope = "git_branch",
	},
	keys = {
		{ "<leader>mm", "<cmd>Grapple toggle<cr>", desc = "Grapple: [M]ake [m]ark" },
		{ "<leader>ml", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple: [M]ark [l]ist" },

		{ "<leader>m1", "<cmd>Grapple select index=1<cr>", desc = "" },
		{ "<leader>m2", "<cmd>Grapple select index=2<cr>", desc = "" },
		{ "<leader>m3", "<cmd>Grapple select index=3<cr>", desc = "" },
		{ "<leader>m4", "<cmd>Grapple select index=4<cr>", desc = "" },
		{ "<leader>m5", "<cmd>Grapple select index=5<cr>", desc = "" },

		{ "<leader>mn", "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple: [M]ark [n]ext" },
		{ "<leader>mp", "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple: [M]ark [p]revious" },
	},
}
