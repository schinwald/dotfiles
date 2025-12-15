-- Converts a hex number to a string
---@return string
function string.from_hex(hex)
	return string.format("#%06x", hex)
end

-- Converts a string to a hex number
---@param str string
---@return integer
function string.to_hex(str)
	return tonumber(str:gsub("#", "0x"), 16)
end

-- Interpolates a string with variables in a python-like format
---@return string
function string.interpolate(str)
	local outer_env = _ENV
	return (
		str:gsub("%b{}", function(block)
			local code = block:match("{(.*)}")
			local exp_env = {}
			setmetatable(exp_env, {
				__index = function(_, k)
					local stack_level = 5
					while debug.getinfo(stack_level, "") ~= nil do
						local i = 1
						repeat
							local name, value = debug.getlocal(stack_level, i)
							if name == k then
								return value
							end
							i = i + 1
						until name == nil
						stack_level = stack_level + 1
					end
					return rawget(outer_env, k)
				end,
			})
			local fn, err = load("return " .. code, "expression `" .. code .. "`", "t", exp_env)
			if fn then
				return tostring(fn())
			else
				error(err, 0)
			end
		end)
	)
end

---@param value string
local function encode_percent(value)
	return (value:gsub("([^%w._-])", function(c)
		return string.format("%%%02X", c:byte())
	end))
end

---@param value string
---@param type 'percent'
function string.encode(value, type)
	local match = {
		percent = encode_percent,
	}

	local encoder = match[type]
	if not encoder then
		error("string.encode type not found")
	end

	return encoder(value)
end

---@param value string
local function decode_percent(value)
	return (value:gsub("%%(%x%x)", function(hex)
		return string.char(tonumber(hex, 16))
	end))
end

---@param value string
---@param type 'percent'
function string.decode(value, type)
	local match = {
		percent = decode_percent,
	}

	local decoder = match[type]
	if not decoder then
		error("string.decoder type not found")
	end

	return decoder(value)
end
