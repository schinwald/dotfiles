local Padding = require("utils.ui.styles.padding")

local M = {}

--- Create a modal
--- opts:
---   width, height: total inner size (buffer area), NOT including border thickness
---   row, col: position (if omitted: centered)
---   relative: "editor" | "cursor" | "win" (default "editor")
---   border: "none"|"single"|"double"|"rounded"|"solid"|"shadow"|table (default "rounded")
---   style: "minimal" (default)
---   zindex: number (optional)
---   focusable: boolean (default true)
---   padding: number | {top,right,bottom,left} (default 0)
---   title: string (optional)  -- simple title line inside content (not border-title)
---   lines: {string,...} initial content lines
function M.View(opts)
	opts = opts or {}
	local pad = Padding.Normalize(opts.padding)
	local border = opts.border or "rounded"
	local relative = opts.relative or "editor"

	local columns = vim.o.columns
	local lines_total = vim.o.lines

	local width = opts.width or math.floor(columns * 0.6)
	local height = opts.height or math.floor(lines_total * 0.3)

	width = math.clamp(width, 10, columns - 4)
	height = math.clamp(height, 3, lines_total - 4)

	local row = opts.row
	local col = opts.col
	if row == nil then
		row = math.floor((lines_total - height) / 2)
	end
	if col == nil then
		col = math.floor((columns - width) / 2)
	end

	local buf = vim.api.nvim_create_buf(false, true)
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile = false
	vim.bo[buf].modifiable = false

	local win = vim.api.nvim_open_win(buf, opts.focusable ~= false, {
		relative = relative,
		row = row,
		col = col,
		width = width,
		height = height,
		style = opts.style or "minimal",
		border = border,
		zindex = opts.zindex,
		focusable = opts.focusable,
	})

	-- basic window defaults for UI
	vim.wo[win].wrap = false
	vim.wo[win].number = false
	vim.wo[win].relativenumber = false
	vim.wo[win].signcolumn = "no"
	vim.wo[win].cursorline = false

	local function set_lines(user_lines)
		local content = user_lines or opts.lines or {}
		if opts.title and opts.title ~= "" then
			content = vim.list_extend({ opts.title, string.rep("─", math.max(1, width)) }, content)
		end

		-- “inner_width” is the full buffer width; padding consumes inside it.
		local padded = Padding.Style(content, pad, width)

		-- fit to height: truncate or add blanks
		if #padded > height then
			local trimmed = {}
			for i = 1, height do
				trimmed[i] = padded[i]
			end
			padded = trimmed
		elseif #padded < height then
			for _ = 1, (height - #padded) do
				table.insert(padded, string.rep(" ", width))
			end
		end

		vim.bo[buf].modifiable = true
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, padded)
		vim.bo[buf].modifiable = false
	end

	set_lines(opts.lines)

	local api = {}

	function api.close()
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
	end

	function api.set_lines(new_lines)
		set_lines(new_lines)
	end

	function api.resize(new_width, new_height)
		if not vim.api.nvim_win_is_valid(win) then
			return
		end
		if new_width then
			width = math.clamp(new_width, 10, vim.o.columns - 4)
			vim.api.nvim_win_set_width(win, width)
		end
		if new_height then
			height = math.clamp(new_height, 3, vim.o.lines - 4)
			vim.api.nvim_win_set_height(win, height)
		end
		set_lines(vim.api.nvim_buf_get_lines(buf, 0, -1, false))
	end

	api.buf = buf
	api.win = win
	return api
end

return M
