require("config.extras.npm")

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local MRU = require("utils.mru")
local json = require("utils.json")

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

	local package_directory = vim.g.npm.find_package_directory()
	if not package_directory then
		vim.notify("No package directory found", vim.log.levels.WARN)
		return
	end

	local mru = MRU.new({
		name = "neotest-open/" .. string.encode(package_directory, "percent"),
		max_entries = 1000,
	})

	local all_scripts = table.map(vim.g.npm.get_script_names(), function(value)
		return {
			type = "package",
			data = value,
		}
	end)

	if not all_scripts or vim.tbl_isempty(all_scripts) then
		vim.notify("No scripts found in package.json", vim.log.levels.WARN)
		return
	end

	local recent_scripts = table.map(mru:get_recent(10), function(value)
		return json.decode(value)
	end)

	local delimiter = {
		{
			type = "decoration",
			data = "───────────────────────────────────────────────────────────",
		},
	}

	local results = all_scripts
	if #recent_scripts > 0 then
		results = table.merge(recent_scripts, delimiter, all_scripts)
	end

	pickers
		.new(opts, {
			prompt_title = "Select script",
			finder = finders.new_table({
				results = results,
				entry_maker = function(entry)
					local prefix
					if entry.type == "package" then
						prefix = package_manager .. ": "
					elseif entry.type == "custom" then
						prefix = "custom: "
					else
						prefix = ""
					end

					return {
						value = entry,
						display = prefix .. entry.data,
						ordinal = entry.data,
					}
				end,
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				local function on_select()
					local selected = action_state.get_selected_entry()

					if selected == nil then
						local input = action_state.get_current_line()
						selected = {
							value = {
								type = "custom",
								data = input,
							},
						}
					end

					mru:update(json.encode(selected.value, { sorted = true }))

					local type
					if selected.value.type == "package" then
						type = package_manager
					elseif selected.value.type == "custom" then
						type = "custom"
					end

					local get_command_from_type = {
						npm = "npm run " .. selected.value.data,
						pnpm = "pnpm " .. selected.value.data,
						yarn = "yarn " .. selected.value.data,
						custom = selected.value.data,
					}

					vim.g.neotest_command = get_command_from_type[type] .. " --"

					actions.close(prompt_bufnr)

					-- Open summary on the next tick, in a normal buffer
					vim.schedule(function()
						vim.cmd("tabnew")

						local neotest = require("neotest")

						-- Open the summary in this tab
						neotest.summary.open()

						-- Close all non-summary windows in this tab
						local wins = vim.api.nvim_tabpage_list_wins(0)
						for _, win in ipairs(wins) do
							local buf = vim.api.nvim_win_get_buf(win)
							local ft = vim.api.nvim_buf_get_option(buf, "filetype")
							if ft ~= "neotest-summary" then
								vim.api.nvim_win_close(win, true)
							end
						end

						-- Open the output panel and move it to the left
						neotest.output_panel.open()
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
