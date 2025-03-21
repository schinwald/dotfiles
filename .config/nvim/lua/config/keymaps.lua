-- Allows moving hunks of code up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move hunk down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move hunk up" })

-- Always center cursor when doing half page navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Navigate page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Navigate page up" })

-- Always center cursor when going to next or previous result in searches
vim.keymap.set("n", "n", "nzzzv", { desc = "Go to next search result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Go to previous search result" })

-- Persist cursor position when joining lines
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line below" })

vim.keymap.set("n", "<leader>mo", "<cmd>MoveOpen<cr>", { desc = "[M]ove [o]pen" })
vim.keymap.set("n", "<leader>mc", "<cmd>MoveClose<cr>", { desc = "[M]ove [c]lose" })

-- Quiting in different contexts
vim.api.nvim_create_user_command("Quit", function()
	if require("diffview.lib").get_current_view() then
		vim.cmd("DiffviewClose")
	else
		vim.cmd("q")
	end
end, {})

vim.cmd("cnoreabbrev q Quit")
