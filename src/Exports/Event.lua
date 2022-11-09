-- Simple Event Library
-- Usage: CatMeowed = Event<boolean>()

local Types = require(script.Parent.Parent.Types)
type Event<A...> = Types.Event<A...>

return function<A...>(): Event<A...>
	local Event = {}
	Event.ConnectedFunctions = {}
	Event.WaitingThreads = {}

	function Event.Connect(self: Event<A...>, func: (A...) -> ()): () -> ()
		local index = #self.ConnectedFunctions + 1
		self.ConnectedFunctions[index] = func

		return function()
			table.remove(self.ConnectedFunctions, index)
		end
	end

	function Event.Wait(self: Event<A...>): A...
		local co = coroutine.running()
		table.insert(self.WaitingThreads, co)
		return coroutine.yield(co)
	end

	function Event.Fire(self: Event<A...>, ...: A...)
		-- first, handoff callbacks
		-- then release threads
		-- do not rely on this order as it's an implementation detail
		for _, callback: (A...) -> () in self.ConnectedFunctions do
			task.spawn(callback, ...)
		end

		for _, thread in self.WaitingThreads do
			coroutine.resume(thread, ...)
		end
	end

	return Event
end