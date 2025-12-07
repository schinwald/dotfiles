local json = {}

---@class JsonEncodeOptions
---@field sorted? boolean  -- if true, sort object keys lexicographically

--- Internal recursive encoder.
---@param value any
---@param opts JsonEncodeOptions
---@param stack table<any, boolean>  -- for cycle detection
---@return string
local function encode_value(value, opts, stack)
	local t = type(value)

	-- Non-table: let vim.json handle it
	if t ~= "table" then
		return vim.json.encode(value)
	end

	-- Cycle detection
	if stack[value] then
		error("json.encode: circular table reference detected")
	end
	stack[value] = true

	local res

	if vim.islist(value) then
		-- ARRAY: keep numeric order
		local parts = {}
		for i = 1, #value do
			parts[i] = encode_value(value[i], opts, stack)
		end
		res = "[" .. table.concat(parts, ",") .. "]"
	else
		-- OBJECT: sort keys optionally
		local keys = {}
		for k, _ in pairs(value) do
			keys[#keys + 1] = k
		end

		if opts.sorted then
			table.sort(keys, function(a, b)
				return tostring(a) < tostring(b)
			end)
		end

		local parts = {}
		for _, k in ipairs(keys) do
			local v = value[k]
			local key_json = vim.json.encode(tostring(k)) -- JSON keys must be strings
			local val_json = encode_value(v, opts, stack)
			parts[#parts + 1] = key_json .. ":" .. val_json
		end

		res = "{" .. table.concat(parts, ",") .. "}"
	end

	stack[value] = nil
	return res
end

--- Encode a Lua value as JSON.
---
--- Usage:
---   json.encode(data)               -- normal, non-sorted
---   json.encode(data, { sorted = true })  -- deterministic key order
---
--- @param value any
--- @param opts? JsonEncodeOptions
--- @return string
function json.encode(value, opts)
	opts = opts or {}
	local ok, result = pcall(encode_value, value, opts, {})
	if not ok then
		error(result) -- bubble up with a useful message
	end
	return result
end

--- Decode JSON string into a Lua value.
--- Returns value, err (err is nil on success).
---
--- @param str string
--- @return any|nil value
--- @return string|nil err
function json.decode(str)
	local ok, result = pcall(vim.json.decode, str)
	if not ok then
		return nil, "json.decode error: " .. tostring(result)
	end
	return result, nil
end

return json
