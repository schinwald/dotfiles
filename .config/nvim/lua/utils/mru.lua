---@class MRUOpts
---@field name string            # logical name for this MRU instance
---@field max_entries? integer   # optional cap; defaults to 100

---@class MRU
---@field _name string
---@field _store table<string, integer>   # key -> last used timestamp
---@field _store_path string
---@field _max_entries integer
local MRU = {}
MRU.__index = MRU

local uv = vim.uv or vim.loop

---Ensure the directory for a path exists.
---@param path string
local function ensure_dir(path)
	local dir = vim.fn.fnamemodify(path, ":h")
	if vim.fn.isdirectory(dir) == 0 then
		vim.fn.mkdir(dir, "p")
	end
end

---Load the JSON store from disk (lazy).
---@param self MRU
---@return table<string, integer>
function MRU:_load_store()
	if self._store ~= nil then
		return self._store
	end

	local fd = uv.fs_open(self._store_path, "r", 438) -- 0666
	if not fd then
		self._store = {}
		return self._store
	end

	local stat = uv.fs_fstat(fd)
	local data = uv.fs_read(fd, stat.size, 0)
	uv.fs_close(fd)

	if not data or data == "" then
		self._store = {}
		return self._store
	end

	local ok, decoded = pcall(vim.json.decode, data)
	if ok and type(decoded) == "table" then
		self._store = decoded
	else
		self._store = {}
	end

	return self._store
end

---Persist the current store to disk.
---@param self MRU
function MRU:_save()
	if not self._store then
		return
	end

	ensure_dir(self._store_path)

	local payload = vim.json.encode(self._store)
	local fd = uv.fs_open(self._store_path, "w", 438) -- 0666
	if not fd then
		return
	end

	uv.fs_write(fd, payload, 0)
	uv.fs_close(fd)
end

---Prune the store to at most `_max_entries` most recent entries.
---@param self MRU
function MRU:_prune()
	local max_entries = self._max_entries or 100
	local entries = {}

	for key, ts in pairs(self._store) do
		table.insert(entries, { key = key, ts = ts })
	end

	if #entries <= max_entries then
		return
	end

	table.sort(entries, function(a, b)
		return a.ts > b.ts
	end)

	local new_store = {}
	for i = 1, max_entries do
		local entry = entries[i]
		new_store[entry.key] = entry.ts
	end

	self._store = new_store
end

---Create a new MRU instance.
---@param opts MRUOpts
---@return MRU
function MRU.new(opts)
	opts = opts or {}

	if type(opts.name) ~= "string" then
		error("MRU.new: opts.name must be a string", 2)
	end

	if opts.max_entries ~= nil and type(opts.max_entries) ~= "number" then
		error("MRU.new: opts.max_entries must be a number", 2)
	end

	local store_path = vim.fn.stdpath("data") .. "/mru/" .. opts.name .. ".json"

	---@type MRU
	local self = setmetatable({
		_name = opts.name,
		_store = nil, -- lazy loaded
		_store_path = store_path,
		_max_entries = opts.max_entries or 100,
	}, MRU)

	self:_load_store()

	return self
end

---Mark a key as used "now".
---@param self MRU
---@param key string
function MRU:update(key)
	if type(key) ~= "string" then
		error("MRU:update: key must be a string", 2)
	end

	self:_load_store()
	self._store[key] = os.time()
	self:_prune()
	self:_save()
end

---Sync MRU with a whitelist of valid keys.
---Any key not present in `keys` will be removed.
---@param self MRU
---@param keys table
function MRU:sync(keys)
	if type(keys) ~= "table" then
		error("MRU:sync: keys must be a list (table) of strings", 2)
	end

	self:_load_store()

	---@type table<string, boolean>
	local whitelist = {}
	for _, k in ipairs(keys) do
		if type(k) == "string" then
			whitelist[k] = true
		end
	end

	local changed = false

	for key in pairs(self._store) do
		if not whitelist[key] then
			self._store[key] = nil
			changed = true
		end
	end

	if changed then
		self:_save()
	end
end

---Remove specific keys from the MRU store.
---@param self MRU
---@param keys table
function MRU:remove(keys)
	if type(keys) ~= "table" then
		error("MRU:remove: keys must be a list (table) of strings", 2)
	end

	self:_load_store()

	local changed = false

	for _, key in ipairs(keys) do
		if type(key) == "string" and self._store[key] ~= nil then
			self._store[key] = nil
			changed = true
		end
	end

	if changed then
		self:_save()
	end
end

---Get the N most recently used keys.
---@param self MRU
---@param n? integer
---@return table
function MRU:get_recent(n)
	self:_load_store()
	n = n or self._max_entries

	---@type { key: string, ts: integer }[]
	local entries = {}

	for key, ts in pairs(self._store) do
		table.insert(entries, { key = key, ts = ts })
	end

	table.sort(entries, function(a, b)
		return a.ts > b.ts
	end)

	local limit = math.min(n, #entries)
	---@type string[]
	local out = {}

	for i = 1, limit do
		out[i] = entries[i].key
	end

	return out
end

return MRU
