local core = require("config.extras.github.utils.core")

local M = {}

function M.repository_url()
	local repository = core.get_repository()
	if not repository then
		return nil, "Could not determine GitHub repository URL."
	end

	return table.concat({ "https://github.com", repository }, "/")
end

function M.file_url()
	local repository, err = core.get_repository()
	if not repository then
		return nil, err
	end

	local candidates = {}
	local seen = {}
	for _, b in ipairs({ core.get_current_branch(), "main", "master" }) do
		if b and not seen[b] then
			seen[b] = true
			table.insert(candidates, b)
		end
	end

	local branch = nil
	for _, candidate in ipairs(candidates) do
		branch = core.get_remote_branch({ branch = candidate, remote = "origin" })
		if branch then
			break
		end
	end

	local file, err = core.get_file()
	if not file then
		return nil, err
	end

	local line_fragment = core.get_line_fragment()

	return table.concat({
		"https://github.com",
		repository,
		"blob",
		branch,
		file,
	}, "/") .. line_fragment
end

function M.commit_url(commit_hash)
	local repository, err = core.get_repository()
	if not repository then
		return nil, err
	end

	return table.concat({
		"https://github.com",
		repository,
		"commit",
		commit_hash,
	}, "/")
end

function M.pull_request_url(pull_request_id)
	local repository, err = core.get_repository()
	if not repository then
		return nil, err
	end

	return table.concat({
		"https://github.com",
		repository,
		"pull",
		pull_request_id,
	}, "/")
end

return M
