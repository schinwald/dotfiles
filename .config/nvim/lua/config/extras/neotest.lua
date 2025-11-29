require("config.extras.npm")

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- Remove wrap from Neotest output panel
vim.api.nvim_create_autocmd("FileType", {
	pattern = "neotest-output-panel",
	callback = function()
		vim.opt.signcolumn = "no"
		vim.opt_local.wrap = false
	end,
})

-- Remove wrap from Neotest summary
vim.api.nvim_create_autocmd("FileType", {
	pattern = "neotest-summary",
	callback = function()
		vim.opt.signcolumn = "no"
		vim.opt_local.wrap = false
	end,
})

-- Telescope picker to select a script
local function pick_npm_script(opts)
	opts = opts or {}

	local package_manager = vim.g.npm.get_package_manager_name()
	if not package_manager then
		vim.notify("No package manager found", vim.log.levels.WARN)
		return
	end

	local scripts = vim.g.npm.get_script_names()
	if not scripts or vim.tbl_isempty(scripts) then
		vim.notify("No scripts found in package.json", vim.log.levels.WARN)
		return
	end

	pickers
		.new(opts, {
			prompt_title = "Select script",
			finder = finders.new_table({ results = scripts }),
			sorter = conf.generic_sorter(opts),

			attach_mappings = function(prompt_bufnr, map)
				local function on_select()
					local selected = action_state.get_selected_entry()
					local script = selected[1]

					local get_command_from_package_manager = {
						npm = "npm run " .. script,
						pnpm = "pnpm " .. script,
						yarn = "yarn " .. script,
					}

					vim.g.neotest_command = get_command_from_package_manager[package_manager] .. " --"

					actions.close(prompt_bufnr)

					-- Open summary on the next tick, in a normal buffer
					vim.schedule(function()
						vim.cmd("tabnew")

						vim.cmd("Neotest summary")

						local wins = vim.api.nvim_tabpage_list_wins(0)
						for _, win in ipairs(wins) do
							local buf = vim.api.nvim_win_get_buf(win)
							local ft = vim.api.nvim_buf_get_option(buf, "filetype")
							if ft ~= "neotest-summary" then
								vim.api.nvim_win_close(win, true)
							end
						end

						vim.cmd("Neotest output-panel")
						vim.cmd("wincmd H")
						vim.cmd("vertical resize 80")
					end)
				end

				map("i", "<CR>", function()
					on_select()
				end)
				map("n", "<CR>", function()
					on_select()
				end)

				return true
			end,
		})
		:find()
end

-- User command: opens telescope picker instead of taking args
vim.api.nvim_create_user_command("NeotestOpen", function()
	vim.schedule(function()
		pick_npm_script()
	end)
end, {
	nargs = 0,
})
