-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Reset search highlighting when leaving search mode
vim.api.nvim_create_autocmd("CursorMoved", {
	group = vim.api.nvim_create_augroup("auto-hlsearch", { clear = true }),
	callback = function()
		if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
			vim.schedule(function()
				vim.cmd.nohlsearch()
			end)
		end
	end,
})

-- Use the default git when opening a new buffer
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("auto-git", { clear = true }),
	callback = function()
		vim.fn.use_default_git()
	end,
})

-- Conflict marker cleanup function
local function clean_conflict_markers()
	local bufnr = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local ns_id = vim.api.nvim_create_namespace("ConflictMarkerHighlight")
	local width = vim.api.nvim_win_get_width(0)
	local highlight_lines = {}

	for i, line in ipairs(lines) do
		local matches_ours = line:match("^<<<<<<<%s+(.+)$")
		local matches_theirs = line:match("^>>>>>>>%s+(.+)$")
		local matches_end = line:match("^=======")

		if matches_ours then
			local text = " OURS "
			local padding = string.rep(" ", math.max(0, width - #text - #matches_ours))
			table.insert(highlight_lines, {
				i - 1,
				{
					{ text, "ConflictOursLabel" },
					{ "- " .. matches_ours .. padding, "ConflictOursContent" },
				},
			})
		elseif matches_theirs then
			local text = " THEIRS "
			local padding = string.rep(" ", math.max(0, width - #text - #matches_theirs))
			table.insert(highlight_lines, {
				i - 1,
				{
					{ text, "ConflictTheirsLabel" },
					{ "- " .. matches_theirs .. padding, "ConflictTheirsContent" },
				},
			})
		elseif matches_end then
			local separator = string.rep("─", math.max(0, width))
			table.insert(highlight_lines, {
				i - 1,
				{
					{ separator, "ConflictEnd" },
				},
			})
		end
	end

	-- Highlight only the lines we changed
	for _, hl in ipairs(highlight_lines) do
		local lnum, virt_text = hl[1], hl[2]
		vim.api.nvim_buf_set_extmark(bufnr, ns_id, lnum, 0, {
			virt_text = virt_text,
			virt_text_pos = "overlay",
		})
	end
end

-- Autocmd: Apply on files with merge conflict markers
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*",
	callback = function()
		-- Check if file contains conflict markers
		local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
		for _, line in ipairs(lines) do
			if line:match("^<<<<<<< ") or line:match("^=======") or line:match("^>>>>>>> ") then
				clean_conflict_markers()
				break
			end
		end
	end,
})

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
	callback = function()
		clean_conflict_markers()

		local ns_id = vim.api.nvim_get_namespaces()["ConflictMarkerHighlight"]

		if ns_id == nil then
			return
		end

		local bufnr = vim.api.nvim_get_current_buf()
		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
		local extmarks = vim.api.nvim_buf_get_extmarks(bufnr, ns_id, 0, -1, {})

		for _, mark in ipairs(extmarks) do
			local id = mark[1]
			local lnum = mark[2]
			local line = lines[lnum + 1]
			-- Remove extmark if the line no longer exists or no longer contains a conflict marker
			if not line or not line:match("^[<>=]+") then
				vim.api.nvim_buf_del_extmark(bufnr, ns_id, id)
			end
		end
	end,
})
