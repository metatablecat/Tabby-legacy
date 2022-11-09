--!strict
-- Action
local Types = require(script.Parent.Parent.Types)
type Action<I..., O...> = Types.Action<I..., O...>

local function asyncHandler<I..., O...>(Action: Action<I..., O...>, Handler: (boolean, O...) -> (), ...: I...	)
	local co = coroutine.create(function(...)	
		Handler(Action:await(...))
	end)

	coroutine.resume(co, ...)
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
			asyncHandler(self, cb, ...) --consumes await
		end,
	}

	return Action
end