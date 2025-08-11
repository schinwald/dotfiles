---Runs the biome linter and opens the files so it appears in diagnostics
vim.api.nvim_create_user_command("BiomeCheck", function()
	local handle = io.popen("biome check --reporter json")

	if not handle then
		return
	end

	local result = handle:read("*a")
	handle:close()

	local ok, data = pcall(vim.json.decode, result)

	if not ok or type(data) ~= "table" then
		print("Failed to parse Biome JSON output")
		return
	end

	if not data.diagnostics then
		print("No diagnostics found")
		return
	end

	for _, file in ipairs(data.diagnostics) do
		local absolute = vim.fn.fnamemodify(file.location.path.file, ":p")
		local uri = vim.uri_from_fname(absolute)
		local bufnr = vim.uri_to_bufnr(uri)
		vim.fn.bufload(bufnr)
	end
end, {})
