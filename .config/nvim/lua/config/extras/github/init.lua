local api = require("config.extras.github.api")

vim.api.nvim_create_user_command("Github", function(opts)
	local args = opts.fargs or {}
	local action = args[1]:lower()

	if action == "open" then
		local type = args[2]:lower()

		if type == "repository" then
			api.open.repository()
		elseif type == "file" then
			api.open.file()
		elseif type == "commit" then
			local commit_hash = args[3]:lower()
			api.open.commit(commit_hash)
		elseif type == "pull_request" then
			local pull_request_id = args[3]:lower()
			api.open.pull_request(pull_request_id)
		else
			vim.api.nvim_echo({ { "Unsupported type: " .. type } }, true, { err = true })
			return
		end
	elseif action == "copy" then
		local type = args[2]:lower()

		if type == "repository" then
			api.copy.repository()
		elseif type == "file" then
			api.copy.file()
		elseif type == "commit" then
			local commit_hash = args[3]:lower()
			api.copy.commit(commit_hash)
		elseif type == "pull_request" then
			local pull_request_id = args[3]:lower()
			api.copy.pull_request(pull_request_id)
		else
			vim.api.nvim_echo({ { "Unsupported type: " .. type } }, true, { err = true })
			return
		end
	else
		vim.api.nvim_echo({ { "Unsupported action: " .. action } }, true, { err = true })
	end
end, {
	nargs = "+",
	range = true,
	desc = "Perform Github actions",
	complete = function()
		return { "open", "copy" }
	end,
})
