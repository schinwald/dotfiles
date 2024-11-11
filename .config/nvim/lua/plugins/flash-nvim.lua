-- https://github.com/folke/flash.nvim
-- [[ Configure Flash ]] See `:help flash`

return {
	"folke/flash.nvim",
	event = "VeryLazy",
	enabled = function()
		---@diagnostic disable: undefined-field
		if vim.g.vscode then
			return false
		end

		return true
	end,
  -- stylua: ignore
  keys = {
    {
      mode = { "n", "x", "o" },
      "s",
      function() require("flash").jump() end,
      desc = "Flash",
    },
    {
      mode = { "n", "x", "o" },
      "S",
      function() require("flash").treesitter() end,
      desc = "Flash Treesitter",
    },
    {
      mode = "o",
      "r",
      function() require("flash").remote() end,
      desc = "Remote Flash",
    },
    {
      mode = { "o", "x" },
      "R",
      function() require("flash").treesitter_search() end,
      desc = "Treesitter Search",
    },
    {
      mode = { "c" },
      "<c-s>",
      function() require("flash").toggle() end,
      desc = "Toggle Flash Search",
    },
  },
	---@type Flash.Config
	opts = {},
}
