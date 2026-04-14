local M = {}

---@class CaptureCodeOptions
---@field reset_to_normal_mode boolean Whether to reset to normal mode after capturing the selection

---Capture the current file reference from a visual selection range
---@param opts CaptureCodeOptions options for capturing code
function M.capture_code_reference(opts)
	opts = opts or {}
	local bufnr = vim.api.nvim_get_current_buf()
	local filename = vim.api.nvim_buf_get_name(bufnr)

	local position = vim.fn.get_visual_selection_range({
		reset_to_normal_mode = opts.reset_to_normal_mode,
	})

	if not position then
		return filename
	end

	if (position["start"].line == position["end"].line) and (position["start"].column == position["end"].column) then
		return string.format("%s (position %d:%d)", filename, position["start"].line, position["start"].column)
	end

	return string.format(
		"%s (position %d:%d to %d:%d)",
		filename,
		position["start"].line,
		position["start"].column,
		position["end"].line,
		position["end"].column
	)
end

return M
