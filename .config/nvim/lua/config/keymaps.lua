-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Keybinds to make split navigation easier
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move fokus to the upper window" })

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
