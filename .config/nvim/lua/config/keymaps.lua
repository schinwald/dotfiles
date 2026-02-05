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

-- Open diagnostics in a floating window
vim.keymap.set("n", "<leader>e", function()
	vim.diagnostic.open_float()
end)

-- Interact with files/folders
vim.keymap.set("n", "<leader>mo", "<cmd>MoveOpen<cr>", { desc = "[M]ove [o]pen" })
vim.keymap.set("n", "<leader>mc", "<cmd>MoveClose<cr>", { desc = "[M]ove [c]lose" })

-- Open a directory in the current window using Zoxide and Oil
vim.keymap.set("n", "<leader>z", "<cmd>Zoxide<cr>", { desc = "[Z]oxide" })

-- View file's abstract syntax tree
vim.keymap.set("n", "<leader>ast", "<cmd>InspectTree<cr>", { desc = "[A]bstract [s]yntax [t]ree" })

-- Close the current tab
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "[T]ab [c]lose" })

-- Github actions
local github = require("config.extras.github.api")
vim.keymap.set({ "n", "v" }, "<leader>ghr", function()
	github.copy.repository()
end, { desc = "[G]it[h]ub copy [r]epository URL" })
vim.keymap.set({ "n", "v" }, "<leader>ghf", function()
	github.copy.file()
end, { desc = "[G]it[h]ub copy [f]ile URL" })
vim.keymap.set({ "n", "v" }, "<leader>ghc", function()
	local commit_hash = vim.fn.expand("<cword>")
	github.copy.commit(commit_hash)
end, { desc = "[G]it[h]ub copy [c]ommit URL" })
vim.keymap.set({ "n", "v" }, "<leader>ghpr", function()
	local pull_request_id = vim.fn.expand("<cword>")
	github.copy.pull_request(pull_request_id)
end, { desc = "[G]it[h]ub copy [p]ull [r]equest URL" })

-- Use to toggle inline diagnostics
vim.api.nvim_create_user_command("DiagnosticsToggleVirtualText", function()
	local enabled = vim.diagnostic.config().virtual_text
	if enabled then
		vim.diagnostic.config({ virtual_text = false })
	else
		vim.diagnostic.config({ virtual_text = true })
	end
end, {})
