--!strict
-- Action
local Types = require(script.Parent.Parent.Types)
type Action<I..., O...> = Types.Action<I..., O...>

local function asyncHandler<I..., O...>(Action: Action<I..., O...>, Handler: (boolean, O...) -> (), ...: I...	)
	local co = coroutine.create(function(...)	
		Handler(Action:await(...))
	end)

	coroutine.resume(co, ...)
	return function(optMsg: string?)
		if coroutine.status(co) ~= "dead" then
			task.cancel(co)

			local Handler = Handler :: (boolean, any) -> ()
			Handler(false, optMsg or "awaitAsync call was cancelled")
			return true
		end

		return false
	end
end

return function<I..., O...>(actionName: string, callback: (I...) -> O...): Action<I..., O...>
	local Action: Action<I..., O...> = {
		Name = actionName,
		ShowWarnings = false,

		_signal = callback,

		await = function(self, ...)
			-- we dont need a thread here
			return xpcall(self._signal, function(err)
				if self.ShowWarnings then
					warn("Action '" .. self.Name .. "' failed; " .. err)
				end

				return err
			end, ...)
		end,

		handleAsync = function(self, cb, ...)
			return asyncHandler(self, cb, ...) --consumes await
		end,
	}

	return Action
end