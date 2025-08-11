-- Dumps a table to the console
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
