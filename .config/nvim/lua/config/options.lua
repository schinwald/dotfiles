vim.g.have_nerd_font = true

-- Decrease update time
vim.opt.updatetime = 250

-- Sets the indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Enables absolute numbers
vim.opt.number = true

-- Enables relative numbers (overlays when absolute is set)
vim.opt.relativenumber = true

-- Enables the mouse
vim.opt.mouse = "a"

-- Disables mode on the statusline since other plugins do this already (ie. lualine)
vim.opt.showmode = false

-- Enables break indent
vim.opt.breakindent = true

-- Persist undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Hide tabline
vim.opt.showtabline = 0

-- Remove ~ from end of file
vim.opt.fillchars = {
	diff = "╱",
	eob = " ",
}
