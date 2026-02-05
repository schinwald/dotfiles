local utils = require("config.extras.github.utils")

return {
	open = {
		repository = function()
			local url, err = utils.url.repository_url()
			if not url then
				vim.api.nvim_echo({ { "Failed to construct repository URL: " .. err } }, true, { err = true })
				return
			end
			vim.fn.browser_open(url)
		end,
		file = function()
			local url, err = utils.url.file_url()
			if not url then
				vim.api.nvim_echo({ { "Failed to construct file URL: " .. err } }, true, { err = true })
				return
			end
			vim.fn.browser_open(url)
		end,
		---@param commit_hash string
		commit = function(commit_hash)
			local url, err = utils.url.commit_url(commit_hash)
			if not url then
				vim.api.nvim_echo({ { "Failed to construct commit URL: " .. err } }, true, { err = true })
				return
			end
			vim.fn.browser_open(url)
		end,
		---@param pull_request_id string
		pull_request = function(pull_request_id)
			local url, err = utils.url.pull_request_url(pull_request_id)
			if not url then
				vim.api.nvim_echo({ { "Failed to construct pull request URL: " .. err } }, true, { err = true })
				return
			end
			vim.fn.browser_open(url)
		end,
	},
	copy = {
		repository = function()
			local url, err = utils.url.repository_url()
			if not url then
				vim.api.nvim_echo({ { "Failed to construct repository URL: " .. err } }, true, { err = true })
				return
			end
			vim.fn.setreg("+", url)
		end,
		file = function()
			local url, err = utils.url.file_url()
			if not url then
				vim.api.nvim_echo({ { "Failed to construct file URL: " .. err } }, true, { err = true })
				return
			end
			vim.fn.setreg("+", url)
		end,
		---@param commit_hash string
		commit = function(commit_hash)
			local url, err = utils.url.commit_url(commit_hash)
			if not url then
				vim.api.nvim_echo({ { "Failed to construct commit URL: " .. err } }, true, { err = true })
				return
			end
			vim.fn.setreg("+", url)
		end,
		---@param pull_request_id string
		pull_request = function(pull_request_id)
			local url, err = utils.url.pull_request_url(pull_request_id)
			if not url then
				vim.api.nvim_echo({ { "Failed to construct pull request URL: " .. err } }, true, { err = true })
				return
			end
			vim.fn.setreg("+", url)
		end,
	},
}
