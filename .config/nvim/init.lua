-- Set the leader key
-- See `:help mapleader`
-- Unset the space key first
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Install package manager
-- `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("utils.vim")
require("utils.string")
require("utils.table")
require("utils.bigfile")

-- Install plugins
require("lazy").setup("plugins", {})

-- Load config files that are dependent on plugins
require("config.options")
require("config.colors")
require("config.keymaps")
require("config.autocmds")
require("config.extras")
