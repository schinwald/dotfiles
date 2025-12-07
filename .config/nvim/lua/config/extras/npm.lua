---@alias PackageManager '"pnpm"' | '"yarn"' | '"npm"'

---@param start_dir string|nil
---@return string|nil
local function find_package_directory(start_dir)
	local dir = start_dir or vim.fn.getcwd()
	local sep = package.config:sub(1, 1)

	while dir and dir ~= "" do
		local pkg = dir .. sep .. "package.json"
		if vim.loop.fs_stat(pkg) then
			return dir
		end
		local parent = vim.fn.fnamemodify(dir, ":h")
		if parent == dir then
			break
		end
		dir = parent
	end

	return nil
end

---@return string|nil
local function find_package_file()
	local root = find_package_directory()
	if not root then
		return nil
	end

	local sep = package.config:sub(1, 1)
	return root .. sep .. "package.json"
end

---@param root string
---@return boolean
local function is_pnpm_project(root)
	local sep = package.config:sub(1, 1)
	local lockfile = root .. sep .. "pnpm-lock.yaml"
	return vim.loop.fs_stat(lockfile) ~= nil
end

---@param root string
---@return boolean
local function is_yarn_project(root)
	local sep = package.config:sub(1, 1)
	local lockfile = root .. sep .. "yarn.lock"
	return vim.loop.fs_stat(lockfile) ~= nil
end

---@return PackageManager|nil
local function get_package_manager_name()
	local root = find_package_directory()
	if not root then
		return nil
	end

	if is_pnpm_project(root) then
		return "pnpm"
	end

	if is_yarn_project(root) then
		return "yarn"
	end

	return "npm"
end

---@return string[]
local function get_script_names()
	local pkg = find_package_file()
	if not pkg then
		return {}
	end

	-- jq -r '.scripts | keys[]' package.json
	local result = vim.fn.systemlist({ "jq", "-r", ".scripts | keys[]", pkg })

	if vim.v.shell_error ~= 0 then
		return {}
	end

	---@type string[]
	local scripts = vim.tbl_filter(function(s)
		return s ~= ""
	end, result)

	table.sort(scripts)

	return scripts
end

---@class NpmHelpers
---@field find_package_directory fun(start_dir:string|nil):string|nil
---@field find_package_file fun():string|nil
---@field get_package_manager_name fun():PackageManager|nil
---@field get_script_names fun():table

---@type NpmHelpers
vim.g.npm = {
	find_package_directory = find_package_directory,
	find_package_file = find_package_file,
	get_package_manager_name = get_package_manager_name,
	get_script_names = get_script_names,
}
