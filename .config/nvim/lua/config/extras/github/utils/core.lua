local M = {}

-- Get the GitHub repository in the format "owner/repo"
function M.get_remote_url()
	local command = ""

	local work_tree = vim.fn.get_git_work_tree()
	if not work_tree then
		return nil, "Not inside a git repository."
	end

	command = "cd %q && git config --get remote.origin.url"
	local remote = vim.fn.system((command):format(work_tree)):gsub("\n", "")
	if remote ~= "" then
		return remote
	end

	return nil, "Could not get remote URL."
end

-- Get the repository name "owner/repo"
function M.get_repository()
	local remote, err = M.get_remote_url()
	if not remote then
		return nil, err
	end

	local repository = remote:match("github.com[:/](.+)%.git$")
	if not repository then
		return nil, "Could not determine GitHub repository URL."
	end

	return repository
end

-- Get the current branch name
function M.get_current_branch()
	local command = ""

	local work_tree = vim.fn.get_git_work_tree()
	if not work_tree then
		return nil, "Not inside a git repository."
	end

	command = "cd %q && git rev-parse --abbrev-ref HEAD"
	local branch = vim.fn.system((command):format(work_tree)):gsub("\n", "")
	if branch ~= "HEAD" then
		return branch
	end

	return nil, "Detached HEAD state."
end

---@class GetRemoteBranchOpts
---@field branch string
---@field remote? string

---@param opts GetRemoteBranchOpts
---@return string|nil, string|nil
function M.get_remote_branch(opts)
	local branch = opts.branch
	local remote = opts.remote or "origin"

	local command = ""

	local work_tree = vim.fn.get_git_work_tree()
	if not work_tree then
		return nil, "Not inside a git repository."
	end

	-- Check if the remote exists
	command = "cd %q && git remote get-url %s >/dev/null 2>&1"
	vim.fn.system((command):format(work_tree, remote))
	if vim.v.shell_error ~= 0 then
		return nil, "Remote " .. remote .. " does not exist."
	end

	-- Check if the branch exists on the remote

	command = "cd %q && git ls-remote --exit-code --heads %s %q >/dev/null 2>&1"
	vim.fn.system((command):format(work_tree, remote, branch))
	if vim.v.shell_error ~= 0 then
		return nil, "Branch " .. branch .. " does not exist on remote " .. remote .. "."
	end

	return branch
end

-- Get the relative file path from the git work tree
function M.get_file()
	local file_path = vim.fn.expand("%:p")
	if file_path == "" then
		return nil, "Buffer is not associated with a file"
	end

	return vim.fn.substitute(file_path, "^" .. vim.fn.escape(vim.fn.get_git_work_tree() or "", "/") .. "/", "", "")
end

-- Get the line fragment based on the current selection/position
function M.get_line_fragment()
	local start_line = vim.fn.getpos("v")[2]
	local end_line = vim.fn.getcurpos()[2]

	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end

	local has_line_fragment = start_line > 0 and end_line > 0

	local line_fragment
	if not has_line_fragment then
		line_fragment = ""
	elseif start_line == end_line then
		line_fragment = "#L" .. start_line
	else
		line_fragment = "#L" .. start_line .. "-L" .. end_line
	end

	-- Reset to normal mode
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, false, true), "n", true)

	return line_fragment
end

return M
