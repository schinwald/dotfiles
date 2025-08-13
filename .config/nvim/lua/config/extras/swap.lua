local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local Path = require("plenary.path")

function vim.fn.swap_to_original(swap_path, swap_dir)
	-- Remove swap dir prefix
	local relative = swap_path:sub(#swap_dir + 2) -- +2 for slash after dir

	-- Remove swap extension (like .swp, .swo, .swn)
	relative = relative:gsub(".sw[ponmlk]$", "") -- remove .swp, .swo, .swn, .swm, etc.

	-- Replace % with path separator
	local sep = package.config:sub(1, 1) -- usually '/' on Unix, '\' on Windows
	local original_path = relative:gsub("%%", sep)

	return original_path
end

local swap_dir = vim.fn.expand("~/.local/state/nvim/swap")

function vim.fn.get_all_swap_files()
	local swap_files = {}

	local fd = vim.loop.fs_scandir(swap_dir)
	if not fd then
		print("Swap directory not found: " .. swap_dir)
		return swap_files
	end

	while true do
		local name, _ = vim.loop.fs_scandir_next(fd)
		if not name then
			break
		end
		if name:match(".sw[ponmlk]$") then -- matches swap files like %Users%...%.swp/.swo/.swn/etc
			table.insert(swap_files, swap_dir .. "/" .. name)
		end
	end
	return swap_files
end

---List all the files in the swap directory
vim.api.nvim_create_user_command("SwapFiles", function()
	local swap_files = vim.fn.get_all_swap_files()
	local files = {}
	for _, swap_file in ipairs(swap_files) do
		local original_path = vim.fn.swap_to_original(swap_file, swap_dir)
		table.insert(files, original_path)
	end

	pickers
		.new({}, {
			prompt_title = "Swap Files",
			finder = finders.new_table({
				results = files,
				entry_maker = function(entry)
					return {
						value = entry,
						display = Path:new(entry):make_relative(vim.loop.cwd()),
						ordinal = entry,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				local function on_select()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					vim.cmd("edit " .. selection.value)
				end

				map("i", "<CR>", on_select)
				map("n", "<CR>", on_select)
				return true
			end,
		})
		:find()
end, {})
