---Dumps a table to the console
---@param object table
---@param indent string
function table.dump(object, indent)
	indent = indent or ""
	if type(object) == "table" then
		for k, v in pairs(object) do
			if type(v) == "table" then
				print(indent .. tostring(k) .. ":")
				table.dump(v, indent .. "  ")
			else
				print(indent .. tostring(k) .. ": " .. tostring(v))
			end
		end
	else
		print(indent .. tostring(object))
	end
end

---Merge any number of tables into a new table.
---Later tables override keys from earlier ones.
---Usage:
---  local merged = tables.merge(t1, t2, t3, ...)
---@param ... table
---@return table
function table.merge(...)
	local result = {}

	-- Iterate over all arguments
	for i = 1, select("#", ...) do
		local t = select(i, ...)
		for _, v in ipairs(t) do
			table.insert(result, v)
		end
	end

	return result
end

---Apply a function to each element of an array-like table and return
---a new array containing the mapped values.
---
---Example:
---  local out = table.map({1, 2, 3}, function(v) return v * 2 end)
---  -- out → {2, 4, 6}
---@param object table
---@param callback fun(value: string, index: number): any
function table.map(object, callback)
	local result = {}
	for i, v in ipairs(object) do
		result[i] = callback(v, i)
	end
	return result
end
