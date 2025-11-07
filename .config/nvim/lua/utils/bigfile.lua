vim.g.bigfile_threshold = 5 * 1024 * 1024 -- 5MB threshold

local bigfile_registered_handlers = {}
local bigfile_state = {
	current = false,
	previous = false,
}

-- Registers a handler for big files
vim.fn.handle_bigfile = function(opts)
	bigfile_registered_handlers[opts.name] = opts
end

local is_bigfile = function(bufnr)
	bufnr = bufnr or 0
	local path = vim.api.nvim_buf_get_name(bufnr)
	if path == "" then
		return false
	end
	local ok, stats = pcall(vim.loop.fs_stat, path)
	return ok and stats and stats.size > vim.g.bigfile_threshold
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = function(args)
		local bufnr = args.buf

		bigfile_state.previous = bigfile_state.current
		bigfile_state.current = is_bigfile(bufnr)

		local is_big = bigfile_state.current
		local was_big = bigfile_state.previous

		if is_big and not was_big then
			for _, handler in pairs(bigfile_registered_handlers) do
				if handler.on_open then
					handler.on_open(bufnr)
				end
			end
		elseif not is_big and was_big then
			for _, handler in pairs(bigfile_registered_handlers) do
				if handler.on_close then
					handler.on_close(bufnr)
				end
			end
		end
	end,
})
