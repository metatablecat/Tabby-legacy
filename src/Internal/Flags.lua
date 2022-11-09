-- Tabby flags are exported to _G and can be turned on from the command bar
-- Make sure to reload the plugin if enabling flags
-- Left here to make it easier to maintain flags, it may not always use this, 
-- to force it to use a new flag table, simply reset _G and reload all plugins on Tabby
local Flags = require(script.Parent.Parent.Flags)
local DEBUG_AlwaysResetFastFlagHost = false
type TabbyFlags = typeof(Flags)

local GET_TABBY_FLAGS = _G.__INTERNAL_TABBY_FASTFLAGS
if not GET_TABBY_FLAGS or DEBUG_AlwaysResetFastFlagHost then --AlwaysResetFastFlagHost isn't a real flag but its used for debugging
	local FLAG_CHANGED_WARNING_SHOWN = false
	local TABBY_FLAG_HOST = Flags

	GET_TABBY_FLAGS = setmetatable({}, {
		__index = function(self: TabbyFlags, key: string): boolean
			assert(typeof(key) == "string", "Flag name must be a string")
			local flagVal = assert(TABBY_FLAG_HOST[key], key .. " is not defined in Tabby Flags!")
			return flagVal
		end,

		__newindex = function(self: TabbyFlags, key: string, newVal: boolean)
			assert(typeof(key) == "string", "Flag name must be a string")
			assert(typeof(newVal) == "boolean", "Flag value must be a boolean")
			assert(TABBY_FLAG_HOST[key], key .. " is not defined in Tabby Flags!")
			TABBY_FLAG_HOST[key] = newVal

			if not FLAG_CHANGED_WARNING_SHOWN then
				warn("To ensure flag changes are replicated, reload all plugins that use Tabby. Some features may be available already.")
				FLAG_CHANGED_WARNING_SHOWN = true
			end
		end,

		__metatable = "The metatable is locked."
	})
	
	_G.__INTERNAL_TABBY_FASTFLAGS = GET_TABBY_FLAGS
end

return GET_TABBY_FLAGS :: TabbyFlags