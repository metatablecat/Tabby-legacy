
local Flags = require(script.Parent.Parent.Flags)
type TabbyFlags = typeof(Flags)
local FLAG_HOST = {}

local GET_TABBY_FLAGS = setmetatable({}, {
	__index = function(self: TabbyFlags, key: string): boolean
		assert(typeof(key) == "string", "Flag name must be a string")
		local flagVal = assert(FLAG_HOST[key], key .. " is not defined in Tabby Flags!")
		return flagVal
	end,

	__newindex = function(self: TabbyFlags, key: string, newVal: boolean)
		assert(typeof(key) == "string", "Flag name must be a string")
		assert(typeof(newVal) == "boolean", "Flag value must be a boolean")
		assert(FLAG_HOST[key], key .. " is not defined in Tabby Flags!")
		FLAG_HOST[key] = newVal
	end,

	__metatable = "The metatable is locked."
})

return GET_TABBY_FLAGS :: TabbyFlags